class DefencesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show_login
  	@claims = Claim.all
  	render "claims/defence/login"
  end

  def login
    @claim = Claim.find(params[:claim_id])
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

  def personaldetails
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/personal_details" 
  end

  def about_claim
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/about_claim" 
  end

  def about_defence
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/about_defence" 
  end

  def preview
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/preview" 
  end

  def confirm
    @claim = @claim || Claim.find(params[:claim_id])
    render "claims/defence/confirmation" 
  end
  
  

end
