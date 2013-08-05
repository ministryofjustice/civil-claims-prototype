class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :pretend_to_authenticate

  def pretend_to_authenticate
    if (( defined? session[:user] ) && (session[:user].to_i > 0 ) )
      @user = Person.find(session[:user])
    else 
      redirect_to '/login_as/claimant'
    end
  end

  def show_editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = true
  end

  def hide_editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = false
  end

end
