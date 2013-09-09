# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def button_to_remove_fields(name, form, association)
    form.hidden_field(:_destroy) + button_to_function(name, "remove_fields(this,'#{association}')", class: "button-secondary")
  end
  
  def button_to_add_fields(directory, name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render "#{directory}/#{association.to_s.singularize}_fields", :f => builder
    end
    button_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "button")
  end

  def inline_date_input(form, date_field_symbol)
    render :partial => 'shared/inline_date', :locals => {f: form, date_field: date_field_symbol }
  end

  def nav_link( action, text )
    link_to_unless_current text, :action => action do
      link_to text, '#', :class => 'active'
    end
  end

  def pp_currency( num )
    number_with_precision( num, strip_insignificant_zeros: true, delimiter: ',' )
  end

  def get_next_navigation_path( referer )
    current_page = -1
    @linkdata.each_with_index do |lnk, i|
      if lnk[:path] == session[:referer]
        current_page = i
      elsif current_page > -1
        return url_for( controller: controller.controller_name  , action: lnk[:path], only_path: true )
      end
    end
    return root_path
  end

  def render_local_navigation
    render :partial => 'shared/navigation', :locals => { :links => @linkdata }
  end

end
