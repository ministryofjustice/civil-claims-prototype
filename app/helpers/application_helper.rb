# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: "btn btn-danger btn-small")
  end
  
  def link_to_add_fields(directory, name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("#{directory}/#{association.to_s.singularize}_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "btn btn-primary")

  end
end
