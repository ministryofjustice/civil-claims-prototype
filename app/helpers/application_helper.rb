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

  def get_header_message
    if 'defences' == params[:controller]
      h1 = "View repossession claim" 
      h2 = "and file a defence"
    else
      h1 = "Recover Property:"
      h2 = "Make a possession claim online"
    end
    
    "#{h1}<br />#{h2}".html_safe
  end

end
