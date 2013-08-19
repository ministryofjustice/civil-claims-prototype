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

  def toggle_inline_help_link( link_text, help_content )
    render :partial => 'shared/inline_help', :locals => {link_text: link_text, help_content: help_content }
  end

  def claimant_navigation_linkdata
    link_data = [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'Claim particulars', :path => 'particulars' },
      { :text => 'Court scheduling', :path => 'scheduling' },
      { :text => 'Statement of truth', :path => 'statement' },
      { :text => 'Fees & payment', :path => 'fees' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end

  def render_claimant_navigation
    render :partial => 'claims/claimant/navigation', :locals => { :links => claimant_navigation_linkdata }
  end
end
