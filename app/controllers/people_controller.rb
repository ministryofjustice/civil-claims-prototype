class PeopleController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]

  def login
    if %w(claimant defendant staff judge).include? params[:role] 
      reset_session
      session[:role] = params[:role]

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
      when 'judge'
        flash[:notice] = "Logged in as a Judge."
        session[:user] = Judge.at_random.id
      end
    end

    redirect_to :root
  end

  def update
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])

    session['editors'][person.id] = false

    if %w(SAVE UPDATE).include? params[:commit].upcase
      params.permit!
      person.update_attributes!(params[:claimant])
      person.update_attributes!(params[:defendant]) #lazy
      person.address.update_attributes!(params[:address])

      respond_to do |format|
        format.html { redirect_to claim_path claim }
        format.js { redirect_to claim_person_path claim, person }
      end
    elsif 'REMOVE' == params[:commit].upcase
      person.delete
      respond_to do |format|
        format.html { redirect_to claim_path claim }
        format.js { render partial: 'people/remove', locals: {claim: claim, person: person} }
      end
    elsif 'CANCEL' == params[:commit].upcase
      person.delete if params.has_key? :delete_on_cancel
      respond_to do |format|
        format.html { redirect_to claim_path claim }
        if params.has_key? :delete_on_cancel
          format.js { render partial: 'people/remove', locals: {claim: claim, person: person} }
        else
          format.js { redirect_to claim_person_path claim, person }
        end
      end
    end
  end

  def show
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])

    options = {}
    options[:type] = person.type.downcase
    options[:show_edit_link] = true

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render partial: 'people/save', locals: {claim: claim, person: person, options:options} }
    end
  end

  def new
    @claim = Claim.find(params[:claim_id])

    case params[:type]
    when 'claimant'
      person = Claimant.create
      person.address = Address.create
      @claim.claimants << person
    when 'defendant'
      person = Defendant.create
      person.address = Address.create
      @claim.defendants << person
    end

    people = get_people(@claim, person)

    @claim.save

    session['editors'] ||= {}
    session['editors'][person.id] = true

    options = build_editor_options( person, people )

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render partial: 'people/add', locals: {claim: @claim, person:person, options: options} }
    end
  end

  def get_people( claim, person )
    people = [person]
    case person.type.downcase
    when 'claimant'
      people = claim.claimants 
    when 'defendant'
      people = claim.defendants
    end
    logger.debug people.inspect
    people
  end

  def build_editor_options( person, people )
    options = {}
    options[:type] = person.type.downcase
    options[:title] = 'Add an additional ' + person.type.titleize
    options[:delete_on_cancel] = true if person.id != people.first.id
    options[:not_the_first] = true if person.id != people.first.id
    options
  end

  def editor
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])
    super(person.id)

    options = {}
    options[:type] = person.type.downcase
    people = claim.send (person.type.downcase + 's').to_sym # horrid

    respond_to do |format|
      format.html { redirect_to claim_path(person.claim) }
      format.js { render partial: 'people/edit', formats: [:js], locals: {claim: claim, person:person, people: people, options:options}}
    end
  end

  def hide_editor
    super(params[:id].to_i)
  end

end
