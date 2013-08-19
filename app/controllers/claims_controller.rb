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
    when 'judge'
      render 'claims/judge/index'
    end
  end

  def delete
    Claim.find(params[:id]).delete
    redirect_to root_path
  end

  def create
    @claim = Claim.new
    @user = @user || Person.find(session[:user])
    @claim.setup_linked_records( @user )
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
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @claim.address_for_possession ||= Address.new 
    render 'claims/claimant/statement'
  end

  def fees
    @claim = Claim.find(params[:id])
    @claim.address_for_possession ||= Address.new
    render 'claims/claimant/fees'
  end

  def confirmation
    @claim = Claim.find(params[:id])
    render 'claims/claimant/confirmation'
  end

  def address
    claim = Claim.find_by_id(params[:id])
    params.permit!
    claim.update_attributes params[:claim]
    claim.address_for_possession.update_attributes params[:address]
    claim.save
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { 
        address = claim.address_for_possession
        render :partial => 'addresses/view_address_for_possession', :format => [:js], :locals => {claim: claim, address: address, options: {}}}
      end
  end

end
