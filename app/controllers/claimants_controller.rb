class ClaimantsController < ApplicationController
  def update
    claimant = Claimant.find(params[:id])
    params.permit!
    claimant.update_attributes!(params[:claimant])

    redirect_to "/claims/#{params[:claim_id]}"
  end
end