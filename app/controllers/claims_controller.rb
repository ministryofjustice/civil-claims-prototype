class ClaimsController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:delete_all]
  before_action :page_title


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
    @claim = Claim.new
    @user = @user || Person.find(session[:user])
    @claim.owner = @user
    @claim.claimants << @user
    @claim.save

    redirect_to claim_path @claim
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
    @claim = Claim.find(params[:id])
    require 'pp'
    params.permit!
    params[:claim][:claimants].each do |p|
      pp p
      if p[1][:id].blank?
        @claim.claimants << Claimant.upcreate(p[1], 'claimant')
        @claim.save
      else
        Claimant.upcreate(p[1], 'claimant')
      end
    end
    params[:claim][:defendants].each do |p|
      pp p
      if p[1][:id].blank?
        @claim.defendants << Defendant.upcreate(p[1], 'defendant')
        @claim.save
      else
        Defendant.upcreate(p[1], 'defendant')
      end
    end

    params[:claim] = params[:claim].except!(:claimants, :defendants)
    @claim.update_attributes params[:claim]

    raise 'hell'

    case params[:commit]
    when 'Save & Continue'
      redirect_to next_navigation_path
    when 'Close'
      redirect_to root_path
    when 'Add another landlord'
      c = Claimant.new
      c.save(validate: false)
      c.create_address
      @claim.claimants << c
      render 'claims/claimant/personal_details'
    when 'Add another tenant'
      d = Defendant.new
      d.save(validate: false)
      d.create_address
      @claim.defendants << d
      render 'claims/claimant/personal_details'
    end
  end

  def personal_details
    @claim = Claim.find(params[:id], :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
    if @claim.defendants.empty?
      @claim.defendants.build
      @claim.primary_defendant.build_address
    end
    if @claim.address.nil?
      @claim.build_address
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

  def address
    claim = Claim.find_by_id(params[:id])
    params.permit!
    claim.update_attributes params[:claim]
    claim.address.update_attributes params[:address]
    claim.save
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { 
        address = claim.address
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
