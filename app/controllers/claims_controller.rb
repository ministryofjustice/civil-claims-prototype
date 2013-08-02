class ClaimsController < ApplicationController
  before_action :pretend_to_login

  def delete
    Claim.find(params[:id]).delete
    redirect_to root_path
  end

  def delete_all
    Claim.delete_all
    reset_session    
    redirect_to root_path
  end

  def create
    @claim = Claim.new
    @claim.owner = @user
    @claim.claimants << Claimant.new(@user.attributes.except('type', 'id'))
    @claim.defendants << Defendant.create_random
    @claim.address_for_possession = Address.create_random
    @claim.save
    redirect_to claim_path @claim
  end

  def show
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
  
    render "claims/personal_details"
  end

  private 

  def pretend_to_login
    @user = User.at_random
  end
end
