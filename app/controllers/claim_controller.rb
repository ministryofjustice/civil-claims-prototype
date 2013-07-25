class ClaimController < ApplicationController
  def index

  end

  def create
    @claim = Claim.new(params[:claim])
    if(@claim.save)
      logger.debug @claim_path
      redirect_to @claim
    else
      render "new"
    end
  end

  def list
  end

  def show
    @claimants = @claim.claimants
    
  end
end
