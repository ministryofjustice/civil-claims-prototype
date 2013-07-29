class ClaimsController < ApplicationController

  def index
    @user = get_user
  end

  def create
    @user = get_user

    @claim = Claim.new
    @claim.user = @user

    person_hash = @user.attributes.except('type').except('id')
    logger.debug(person_hash)

    @claimant = Claimant.new(person_hash)
    @defendant = Defendant.new

    @claim.claimants << @claimant
    @claim.defendants << @defendant

    @claim.save

    redirect_to claim_path @claim
  end

  def show
    @user = get_user

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
end
