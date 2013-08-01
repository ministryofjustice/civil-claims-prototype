class PeopleController < ApplicationController
  def update
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:id])

    if params[:commit].downcase == 'save'
      params.permit!
      person.update_attributes!(params[:claimant])
      person.address.update_attributes!(params[:address])
    end

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

    session['editors'][person.id] = true
    redirect_to claim_path claim
  end


  def show_editor
    person = Person.find(params[:id])
    session['editors'] ||= {}
    session['editors'][person.id] = true

    redirect_to claim_path(person.claim)
  end

  def hide_editor
    session['editors'][params[:id].to_i] = false
  end

end
