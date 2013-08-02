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

  def personal_details
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
  end

  def particulars
    @claim = Claim.find(params[:id])
  end

  def scheduling
    @claim = Claim.find(params[:id])
  end

  def statement
    @claim = Claim.find(params[:id])
  end

  def fees
    @claim = Claim.find(params[:id])
  end

  def confirmation
    @claim = Claim.find(params[:id])
  end

  private 

  def pretend_to_login
    @user = User.at_random
  end
end
