module ClaimHelper
  def editing?( person, editors )
    #editors.has_key? person.id
    editors[person.id]
  end

  def nav_link( action, text )
    link_to_unless_current text, :action => action do
      link_to text, '#', :class => 'active'
    end
  end

  def login_link_to_role( role )
    url = '/login_as/' + role
    content = role.titleize
    if session[:role] == role
      link_to content, url, :class => 'current_role'
    else
      link_to content, url
    end
  end
end
