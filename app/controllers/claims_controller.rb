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
    return render :text => params

    @claim = Claim.find(params[:id])

    # params[:claim] = params[:claim].permit!

    # @claim.update_attributes(params[:claim])
    # .except!(:claimants, :defendants).permit!
    params.permit!
    @claim.update_attributes params[:claim]
    


    # if params[:claim].has_key? :claimants_attributes
    #   params[:claim][:claimants_attributes].each do |p|
        
    #     # @claim.claimants.new(p)
    #   end
    # end

    case params[:commit]
    when 'Save & Continue'

      # redirect_to next_navigation_path
      render 'claims/claimant/personal_details'
    when 'Close'
      # redirect_to root_path
      # render 'claims/claimant/personal_details'
      render :text => params
    when 'Add another landlord'
      address = Address.create()
      claimant = @claim.claimants.create(:full_name => 'claimant', :address => address)
      render 'claims/claimant/personal_details'
    when 'Add another tenant'
      # d = Defendant.new
      # d.save(validate: false)
      # d.create_address
      # @claim.defendants << d
      render 'claims/claimant/personal_details'
    when 'Same address as first claimant'
      render :text => "asdfafss"
      
    end

    render :text => "asdfafss"
  end

  def personal_details
    @claim = Claim.find(params[:id])
    # , :include => [{:claimants => :address}, {:defendants => :address}])
    @editors = session['editors'] || {}
    if @claim.defendants.empty?
      defendant = @claim.defendants.new(address: Address.new)
      # defendant.address.new
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

  def next_navigation_path
    view_context.get_next_navigation_path request.referer
  end

  def page_title 
    @page_title = "Repossess a property:<br />make a possession claim".html_safe
  end

end
