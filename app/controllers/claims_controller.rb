require 'pp'

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
      render 'claims/staff/index', :layout => 'staff'
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
    @claim = Claim.create(:owner => @user, :claimants => [@user])

    redirect_to personal_details_claim_path @claim
  end

  def login
    hide_user_nav
    render 'claims/claimant/login'
  end


  def update
    @claim = Claim.find(params[:id])
    params.permit!
    @claim.update_attributes params[:claim]

    case params[:commit]
    when 'save-and-continue'
      redirect_to next_navigation_path
    when 'close'
      redirect_to root_path
    end
  end

  def post_personal_details

    if params.has_key? 'destroy'
      Person.delete(params[:destroy])
      @claim = Claim.find(params[:id])
      redirect_to personal_details_claim_path @claim
      return
    end

    @claim = Claim.find(params[:id])

    params.permit!

    # why doesn't it work normally?
    @claim.address.update_attributes params[:claim][:address]
    params[:claim].except!(:address)
    @claim.update_attributes params[:claim]


    if params.has_key? 'same-address-as-first-tenant'
      a = Address.find(params['same-address-as-first-tenant'])
      a.copy_from @claim.primary_defendant.address
      a.save
      @claim.reload
    elsif params.has_key? 'same-address-as-first-landlord'
      a = Address.find(params['same-address-as-first-landlord'])
      a.copy_from @claim.primary_claimant.address
      a.save
      @claim.reload
    end


    case params[:commit]
    when 'save-and-continue'
      redirect_to next_navigation_path
    when 'close'
      redirect_to root_path
    when 'Add another landlord'
      @claim.claimants.create(:address => Address.create)
      redirect_to personal_details_claim_path @claim
    when 'Add another tenant'
      @claim.defendants.create(:address => Address.create)
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
    session[:referer] = 'court_booking'
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

  def case
    render 'claims/staff/case', :layout => 'staff'
  end

  def before
    render 'claims/claimant/before'
  end


  private

    def hide_user_nav
      @hide_user_nav = true
    end

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
        { :text => 'County Court', :path => 'court_booking' },
        { :text => 'Confirm details', :path => 'statement' },
        { :text => 'Pay court fee', :path => 'fees' },
        { :text => 'Confirmation', :path => 'confirmation' }
      ]
    end

end
