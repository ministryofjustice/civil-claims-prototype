class DefencesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show_login
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
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/view" 
  end

  def personal_details
    @claim = @claim || Claim.find(params[:claim_id])
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
    session[:referer] = 'preview'
    render "claims/defence/preview" 
  end

  def confirm
    @claim = @claim || Claim.find(params[:claim_id])
    session[:referer] = 'confirmation'
    render "claims/defence/confirmation" 
  end

  def update
    if 'Save & Continue' == params[:commit]
      redirect_to next_navigation_path
    elsif 'Close' == params[:commit]
      redirect_to root_path
    end
  end

  private
    def next_navigation_path
      view_context.get_defence_next_navigation_path request.referer
    end
  
  

end
