module ClaimHelper
  def editing?( person, editors )
    #editors.has_key? person.id
    editors[person.id]
  end

  def show_dx_controls( person )
    !(person.dx_number.blank? && person.dx_exchange.blank?)
  end

  def dx_controls( form_builder )
    markup = capture { form_builder.input :dx_number, :label => 'DX number' }
    markup << capture { form_builder.input :dx_exchange, :label => 'DX exchange' }
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

  def claimant_navigation_linkdata
    link_data = [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'Case details', :path => 'case_details' },
      { :text => 'Court booking', :path => 'court_booking' },
      { :text => 'Confirm details', :path => 'statement' },
      { :text => 'Pay court fee', :path => 'fees' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end

  def render_claimant_navigation
    render :partial => 'shared/navigation', :locals => { :links => claimant_navigation_linkdata }
  end

  def get_next_navigation_path( referer )
    current_page = -1
    claimant_navigation_linkdata.each_with_index do |lnk, i|
      if lnk[:path] == session[:referer]
        current_page = i
      elsif current_page > -1
        return url_for( controller: 'claims', action: lnk[:path], only_path: true )
      end
    end
    return root_path
  end
end
