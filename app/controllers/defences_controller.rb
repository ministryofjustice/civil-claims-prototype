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
    @claim = @claim || Claim.find(params[:claim_id])
    @user = @user || Person.find(session[:user])
  	render "claims/defence/index"
  end

  def view
    no_page_title
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/view" 
  end

  def personal_details
    @claim = @claim || Claim.find(params[:claim_id])
    # until we have a nice save
    if @claim.defenses.size==0 then
      new_defense = Defense.new
      new_defense.owner= @user
      @claim.defenses << new_defense
      @claim.save
    end

    @editors = session['editors'] || {}
    session[:referer] = 'personal_details'
    render "claims/defence/personal_details" 
  end

  def about_claim
    @claim = @claim || Claim.find(params[:claim_id])
    session[:referer] = 'about_claim'
    render "claims/defence/about_claim" 
  end

  def about_defence
    @claim = @claim || Claim.find(params[:claim_id])
    session[:referer] = 'about_defence'
    render "claims/defence/about_defence" 
  end

  def preview
    @claim = @claim || Claim.find(params[:claim_id])
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
    # update claim defence
    if 'Save & Continue' == params[:commit]
      redirect_to next_navigation_path
    elsif 'Close' == params[:commit]
      @claim = @claim || Claim.find(params[:claim_id])
      redirect_to claim_defence_path @claim
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

end
