class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :pretend_to_authenticate

  def pretend_to_authenticate
    if !Claimant.any?
      raise "No claimants were found in DB"
    end

    bypass = session.has_key? :bypass_auth
    logged_in = (session.has_key? :user) && (session[:user].to_i > 0 )

    logger.debug 'User is logged in.' if logged_in 

    if !bypass
      if logged_in
        @user = Person.find_by_id(session[:user])
        redirect_to '/login_as/claimant' if !@user
      else 
        redirect_to '/login_as/claimant'
      end
    end
  end

  def editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = true
  end

  def hide_editor(person_id)
    session['editors'] ||= {}
    session['editors'][person_id] = false
  end

  def delete_all
    Claim.delete_all
    unless Rails.env.production?
      Person.delete_all
      Address.delete_all
      `rake db:seed RAILS_ENV=#{Rails.env}` #sickandwrong
    end
    reset_session    
    redirect_to root_path
  end

  def next_navigation_path
    view_context.get_next_navigation_path request.referer
  end

  def current_page
    request.referer
  end
end
