module ClaimHelper
  def editing?( person, editors )
    #editors.has_key? person.id
    editors[person.id]
  end

  def show_dx_controls( person )
    !(person.dx_number.blank? && person.dx_exchange.blank?)
  end

  def dx_controls( person )
    markup = ''
    simple_fields_for person do |f|
      markup = capture { f.input :dx_number, :label => 'DX number' }
      markup << capture { f.input :dx_exchange, :label => 'DX exchange' }
    end
    markup
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

  def linkdata
    [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'Case details', :path => 'case_details' },
      { :text => 'Court booking', :path => 'court_booking' },
      { :text => 'Confirm details', :path => 'statement' },
      { :text => 'Pay court fee', :path => 'fees' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end
end
