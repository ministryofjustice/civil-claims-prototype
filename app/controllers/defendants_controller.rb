class DefendantsController < ApplicationController
  def update
    defendant = Defendant.find(params[:id])
    params.permit!
    defendant.update_attributes!(params[:defendant])

    redirect_to "/claims/#{params[:claim_id]}"
  end
end