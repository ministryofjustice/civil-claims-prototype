class ClaimsController < ApplicationController
  def index

  end

  def create
    @claim = Claim.create
    @claimant = Claimant.create
    @defendant = Defendant.create

    @claim.claimants << @claimant
    @claim.defendants << @defendant

    render "claims/edit"
  end

  def list
  end

  def show
    @claim = Claim.find(params[:id])
    @claimant = @claim.claimants.first
    @defendant = @claim.defendants.first

    render "claims/edit"
  end
end
