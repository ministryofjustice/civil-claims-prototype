class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
