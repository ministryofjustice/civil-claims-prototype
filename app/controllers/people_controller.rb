class PeopleController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]

  def login
    if %w(claimant defendant staff).include? params[:role] 
      reset_session
      session[:role] = params[:role]
      session[:user] = 1 unless defined? params[:user]

      case params[:role]
      when 'claimant'
        flash[:notice] = 'Logged in as a claimant.'
        session[:user] = Claimant.at_random.id
      when 'defendant'
        flash[:notice] = 'Logged in as a defendant.'
        session[:user] = Defendant.at_random.id
      when 'staff'
        flash[:notice] = "Logged in as Court Staff."
        session[:user] = Staff.at_random.id
      end
    end

    redirect_to :root
  end

  def update
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])

    if params[:commit].downcase == 'save'
      params.permit!
      person.update_attributes!(params[:claimant])
      person.address.update_attributes!(params[:address])
    end

    session['editors'][person.id] = false

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { redirect_to claim_person_path claim, person }
    end
  end

  def show
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render partial: 'people/save', locals: {person: person} }
    end
  end

  def new
    claim = Claim.find(params[:claim_id])

    case params[:type]
    when 'claimant'
      person = Claimant.create(Person.generate)
      claim.claimants << person
    when 'defendant'
      person = Defendant.create(Person.generate)
      claim.defendants << person
    end

    claim.save

    session['editors'] ||= {}
    session['editors'][person.id] = true
    redirect_to claim_path claim
  end


  def show_editor
    person = Person.find(params[:id])
    super(person.id)

    redirect_to claim_path(person.claim)
  end

  def hide_editor
    super(params[:id].to_i)
  end

end
