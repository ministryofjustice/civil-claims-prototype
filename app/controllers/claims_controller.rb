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
    claim.update_attributes params[:claim]
 
    if 'Save & Continue' == params[:commit]
      redirect_to continue_to_url( request.referer )
    elsif 'Close' == params[:commit]
      redirect_to root_path
    end
  end

  def personal_details
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])

    @editors = session['editors'] || {}
    session[:referer] = 'personal_details'
    render 'claims/claimant/personal_details'
  end

  def particulars
    @claim = Claim.find(params[:id])
    session[:referer] = 'particulars'
    render 'claims/claimant/particulars'
  end

  def scheduling
    @claim = Claim.find(params[:id])
    session[:referer] = 'scheduling'
    render 'claims/claimant/scheduling'
  end

  def statement
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @claim.address_for_possession ||= Address.new 
    session[:referer] = 'statement'
    render 'claims/claimant/statement'
  end

  def fees
    @claim = Claim.find(params[:id])
    @claim.address_for_possession ||= Address.new
    session[:referer] = 'fees'
    render 'claims/claimant/fees'
  end

  def confirmation
    @claim = Claim.find(params[:id])
    session[:referer] = 'confirmation'
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

  private

  def continue_to_url( referer )
    navlinks = view_context.claimant_navigation_linkdata
    current_page = -1
    navlinks.each_with_index do |lnk, i|
      if lnk[:path] == session[:referer]
        current_page = i
      elsif current_page > -1
        return url_for( controller: 'claims', action: lnk[:path], only_path: true )
      end
    end
    return root_path
  end
end
