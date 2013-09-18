class ArrearsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]
  before_action :get_current_claim

  def create 
    # get arrear data from params
    @claim_id = params[:claim_id]
    @new_attachment = @claim.attachments.create

    respond_to do |format|
      # format.html { redirect_to "google.com" }
      format.js
    end
  end

  def destroy
    @arrear_id = params[:id]
    @claim.arrears.find_by(@arrear_id).delete

    respond_to do |format|
      # format.html { redirect_to "google.com" }
      format.js
    end
  end

  private 
    def get_current_claim
      @claim = Claim.find(params[:claim_id])
    end


end
