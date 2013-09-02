class ClaimsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:delete_all]
  before_action :page_title

  decorates_assigned :claim

  def home
    case session[:role]
    when 'claimant'
      render 'claims/claimant/index'
    when 'defendant'
      redirect_to claims_defence_path
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
    @claim = Claim.new.decorate
    @user = @user || Person.find(session[:user])
    @claim.setup_linked_records( @user )
    @claim.save

    redirect_to claim_path @claim
  end

  def update
    @claim = Claim.find(params[:id])
    params.permit!
    @claim.update_attributes params[:claim]
 
    if 'Save & Continue' == params[:commit]
      redirect_to next_navigation_path
    elsif 'Close' == params[:commit]
      redirect_to root_path
    elsif 'Add another landlord' == params[:commit]
      @claim.claimants << Claimant.new( address: Address.new )
      render 'claims/claimant/personal_details'
    end
  end

  def personal_details
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
    session[:referer] = 'personal_details'
    render 'claims/claimant/personal_details'
  end

  def case_details
    @claim = Claim.find(params[:id])
    session[:referer] = 'case_details'
    render 'claims/claimant/case_details'
  end

  def court_booking
    @claim = Claim.find(params[:id])
    session[:referer] = 'scheduling'
    render 'claims/claimant/court_booking'
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
        options = { :show_edit_link => true }
        render :partial => 'addresses/view_address_for_possession', :format => [:js], :locals => {claim: claim, address: address, options: options}
      }
    end
  end

  private

  def next_navigation_path
    view_context.get_next_navigation_path request.referer
  end

  def page_title 
    @page_title = "Repossess a property:<br />make a possession claim".html_safe
  end


end
