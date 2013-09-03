class DefencesController < ApplicationController
  before_action :page_title

  def show_login
    @user = @user || Defendant.find(session[:user])
  	render "claims/defence/login"
  end

  def login
    @claim = Claim.new.create_as_per_user_journey
    @claim.save

    redirect_to claim_defence_path @claim
  end

  def index
    @claim = get_current_claim
    @user = @user || Defendant.find(session[:user])
  	render "claims/defence/index"
  end

  def view
    no_page_title
    @claim = get_current_claim
    render "claims/defence/view" 
  end

  def personal_details
    @claim = get_current_claim
    if get_current_defense.nil?
      @user = Defendant.find(session[:user])
      @claim.defenses.create(owner: @user)
    end

    @editors = session['editors'] || {}
    session[:referer] = 'personal_details'
    render "claims/defence/personal_details" 
  end

  def about_claim
    @defense = get_current_defense
    session[:referer] = 'about_claim'
    render "claims/defence/about_claim" 
  end

  def about_defence
    @claim = get_current_claim
    session[:referer] = 'about_defence'
    render "claims/defence/about_defence" 
  end

  def preview
    @claim = get_current_claim
    @editors = session['editors'] || {}
    session[:referer] = 'preview'
    render "claims/defence/preview" 
  end

  def confirmation
    @claim = @claim || Claim.find(params[:claim_id])
    session[:referer] = 'confirmation'
    render "claims/defence/confirmation" 
  end

  def update
    get_current_defense.update_attributes defense_params

    if 'Save & Continue' == params[:commit]
      redirect_to next_navigation_path
    elsif 'Close' == params[:commit]
      redirect_to claim_defence_path params[:claim_id]
    end
  end

  private

    def next_navigation_path
      view_context.get_defence_next_navigation_path request.referer
    end
    
    def page_title 
      @page_title = "View repossession claim<br />and file a defence".html_safe
    end

    def no_page_title
      @page_title = nil
    end

    def get_current_claim
      @claim || Claim.find(params[:claim_id])
    end

    def get_current_defense
      @defense || Defense.find_by(claim_id: params[:claim_id], owner_id: session[:user])
    end

    def defense_params
      params.require(:defense).permit! if params.has_key? :defense
    end

end
