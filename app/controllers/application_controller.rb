class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def show_editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = true
  end

  def hide_editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = false
  end

end
