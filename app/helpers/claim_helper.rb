module ClaimHelper
  def editing?( person, editors )
    #editors.has_key? person.id
    editors[person.id]
  end

  def show_dx_controls_for( person )
    person.dx_number.present? || person.dx_exchange.present?
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



end
