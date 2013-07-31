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
    @claim.save

    redirect_to claim_path @claim
  end

  def show
    @claim = Claim.find(params[:id])
    init_editables(@claim) if(!session[@claim.id])

    @editors = session[@claim.id]
  
    render "claims/edit"
  end

  def init_editables(claim)
    session[claim.id] = {}
    claimant_ids = claim.claimants.map { |claimant| claimant.id }
    defendant_ids = claim.defendants.map { |defendant| defendant.id }
    (claimant_ids + defendant_ids).each do |id|
      session[claim.id][id] = false
    end
  end

  private 

  def pretend_to_login
    @user = User.at_random
    logger.debug @user
  end
end
