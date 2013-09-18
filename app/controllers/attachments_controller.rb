class AttachmentsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]
  before_action :get_attachment_parent_by_type_from_params

  def create 
    @type = params[:type]
    @claim_id = params[:claim_id]
    @new_attachment = @attachment_parent.attachments.create

    respond_to do |format|
      format.html { redirect_to claim_defence_path(claim_id: params[:claim_id]) }
      format.js
    end
  end

  def destroy
    @attachment_id = params[:id]
    @attachment_parent.attachments.find_by(@attachment_id).delete

    respond_to do |format|
      format.html { redirect_to claim_defence_path(claim_id: params[:claim_id]) }
      format.js
    end
  end

  private 
    def get_attachment_parent_by_type_from_params
      @attachment_parent = 
        case params[:type]
        when 'claim'     
          Claim.find(params[:claim_id])
        when 'defence'
          Defense.find_by(claim_id: params[:claim_id], owner_id: session[:user])
        end
    end


end