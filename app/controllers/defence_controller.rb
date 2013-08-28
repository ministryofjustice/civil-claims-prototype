class DefenceController < ApplicationController
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
  	
  	render "claims/defence/index"
  	
  end
end
