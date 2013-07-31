class PeopleController < ApplicationController
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
