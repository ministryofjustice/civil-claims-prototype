class DefencesController < ApplicationController
  before_action :page_title, :page_links

  def show_login
    @user = @user || Defendant.find(session[:user])
    @hide_user_nav = true
  	render "claims/defence/login"
  end

  def login
    @claim = Claim.new.create_as_per_user_journey
    @claim.save

    redirect_to claim_defence_path @claim
  end

  def index
    get_current_claim
    get_current_defense
    @user = @user || Defendant.find(session[:user])
    render "claims/defence/index"
  end

  def view
    no_page_title
    get_current_claim
    render "claims/defence/view"
  end

  def personal_details
    get_current_claim

    # to the post
    if get_current_defense.nil?
      @user = Defendant.find(session[:user])
      @claim.defenses.create(owner: @user)
    end

    @editors = session['editors'] || {}
    session[:referer] = 'personal_details'
    render "claims/defence/personal_details"
  end

  def about_claim
    get_current_defense
    session[:referer] = 'about_claim'
    render "claims/defence/about_claim"
  end

  def about_defence
    get_current_claim
    get_current_defense
    session[:referer] = 'about_defence'
    render "claims/defence/about_defence"
  end

  def preview
    get_current_claim
    @editors = session['editors'] || {}
    session[:referer] = 'preview'
    render "claims/defence/preview"
  end

  def confirmation
    get_current_claim
    session[:referer] = 'confirmation'
    render "claims/defence/confirmation"
  end

  def update
    update_from_parameters

    if 'Save & Continue' == params[:commit]
      redirect_to next_navigation_path
    elsif 'Close' == params[:commit]
      redirect_to claim_defence_path params[:claim_id]
    end
  end

  private

  def page_title
    @page_title = "View repossession claim<br />and file a defence".html_safe
  end

  def no_page_title
    @page_title = nil
  end

  def get_current_claim
    @claim = @claim || Claim.find(params[:claim_id])
  end

  def get_current_defense
    @defense = @defense || Defense.find_by(claim_id: params[:claim_id], owner_id: session[:user])
  end

  def get_current_defendant
    @defendant = Person.find(session[:user])
  end

  def defense_params
    params.require(:defense).permit! if params.has_key? :defense
  end

  def update_from_parameters
    pp params
    if params.has_key? :personal_details
      update_current_defendant_from_parameters
    else
      update_current_defense_from_parameters
    end
  end

  def update_current_defendant_from_parameters
    get_current_defendant.update_attributes defense_params[:defendant]
  end

  def update_current_defense_from_parameters
    get_current_defense.update_attributes defense_params
  end

  def page_links
    @linkdata = linkdata
  end

  def linkdata
    [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'About the case', :path => 'about_claim' },
      { :text => 'About you', :path => 'about_defence' },
      { :text => 'Preview and submit', :path => 'preview' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end  

end
