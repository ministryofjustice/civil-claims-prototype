class ClaimsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:delete_all]
  before_action :page_title, :page_links


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

  def show
    @claim = Claim.find(params[:id])
    redirect_to personal_details_claim_path @claim
  end


  def create

    @user = @user || Person.find(session[:user])
    @claim = Claim.new(:owner => @user)
    @claim.claimants << @user
    @claim.save

    redirect_to personal_details_claim_path @claim
  end



  def update
    @claim = Claim.find(params[:id])
    params.permit!
    @claim.update_attributes params[:claim]

    case params[:commit]
    when 'Save & Continue'
      redirect_to next_navigation_path
    when 'Close'
      redirect_to root_path
    end
  end

  def post_personal_details

    if params.has_key? 'destroy'
      Person.delete(params[:destroy])
      @claim = Claim.find(params[:id])
      pp params
      redirect_to personal_details_claim_path @claim
      return
    end

    @claim = Claim.find(params[:id])

    params.permit!
    pp params

    # why doesn't it work normally?
    @claim.address.update_attributes params[:claim][:address]
    params[:claim].except!(:address)
    @claim.update_attributes params[:claim]


    if params.has_key? 'same-address-as-first-tenant'
      t = Person.find(params['same-address-as-first-tenant'])
      t.address = @claim.primary_defendant.address.dup
      t.save
    elsif params.has_key? 'same-address-as-first-landlord'
      t = Person.find(params['same-address-as-first-landlord'])
      t.address = @claim.primary_claimant.address.dup
      t.save
    end


    case params[:commit]
    when 'Save & Continue'
      # redirect_to next_navigation_path
      redirect_to personal_details_claim_path @claim
    when 'Close'
      redirect_to root_path
    when 'Add another landlord'
      logger.debug('adding another landlord')
      address = Address.create
      @claim.claimants << Claimant.create(:address => address)
      redirect_to personal_details_claim_path @claim
    when 'Add another tenant'
      address = Address.create
      @claim.defendants.create(:address => address)
      redirect_to personal_details_claim_path @claim
    else
      redirect_to personal_details_claim_path @claim
    end

  end

  def personal_details
    @claim = Claim.find(params[:id])
    @editors = session['editors'] || {}
    if @claim.defendants.empty?
      defendant = @claim.defendants.new(address: Address.new)
    end
    if @claim.address.nil?
      @claim.build_address
      @claim.save
    end
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
    session[:referer] = 'statement'
    render 'claims/claimant/statement'
  end

  def fees
    @claim = Claim.find(params[:id])
    session[:referer] = 'fees'
    render 'claims/claimant/fees'
  end

  def confirmation
    @claim = Claim.find(params[:id])
    session[:referer] = 'confirmation'
    render 'claims/claimant/confirmation'
  end

  # def address
  #   claim = Claim.find_by_id(params[:id])
  #   params.permit!
  #   claim.update_attributes params[:claim]
  #   claim.address.update_attributes params[:address]
  #   claim.save
    
  #   respond_to do |format|
  #     format.html { redirect_to :back }
  #     format.js { 
  #       address = claim.address
  #       options = { :show_edit_link => true }
  #       render :partial => 'addresses/view_address_for_possession', :format => [:js], :locals => {claim: claim, address: address, options: options}
  #     }
  #   end
  #   # render :text => 'sdf'
  # end

  private

  def page_title 
    @page_title = "Repossess a property:<br />make a possession claim".html_safe
  end


  def page_links
    @linkdata = linkdata
  end

  def linkdata
    [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'Case details', :path => 'case_details' },
      { :text => 'Court booking', :path => 'court_booking' },
      { :text => 'Confirm details', :path => 'statement' },
      { :text => 'Pay court fee', :path => 'fees' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end

end
