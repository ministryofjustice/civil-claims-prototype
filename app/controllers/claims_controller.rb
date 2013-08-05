class ClaimsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:delete_all]

  def home
    case session[:role]
    when 'claimant'
      render 'claims/claimant/index'
    when 'defendant'
      render 'claims/defendant/index'
    when 'staff'
      render 'claims/staff/index'
    end
  end

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
    @claim.owner = @user || Person.find(session[:user])
    @claim.claimants << Claimant.new(@user.attributes.except('type', 'id'))
    @claim.defendants << Defendant.create_random
    @claim.address_for_possession = Address.create_random

    #just for now
    3.times { 
      attachment = Attachment.create_random 
      @claim.attachments.push(attachment)
    }
    
    @claim.save
    redirect_to claim_path @claim
  end

  def update
    claim = Claim.find(params[:id])
    params.permit!
    if claim.update_attributes params[:claim]
      redirect_to :back
    else 
      render :text => "error"
    end
    
  end

  def personal_details
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
    render 'claims/claimant/personal_details'
  end

  def particulars
    @claim = Claim.find(params[:id])
    render 'claims/claimant/particulars'
  end

  def scheduling
    @claim = Claim.find(params[:id])
    render 'claims/claimant/scheduling'
  end

  def statement
    @claim = Claim.find(params[:id])
    render 'claims/claimant/statement'
  end

  def fees
    @claim = Claim.find(params[:id])
    render 'claims/claimant/fees'
  end

  def confirmation
    @claim = Claim.find(params[:id])
    render 'claims/claimant/confirmation'
  end

end
