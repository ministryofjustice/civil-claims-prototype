module PersonHelper
  def display_landlords( claim )
    show( claim, 'claimant' )
  end

  def display_tenants( claim )
    show( claim, 'defendant' )
  end


  def show(claim, person_type)
    people = claim.get_people_of_type( person_type )
    editor_showing = false

    people.each.with_index do |person, i|
      options = {}
      options[:class] = '' 
      
      if(@editors[person.id] || person.full_name.blank? ) 
        options[:show_dx] = true if 'claimant' == person.type.downcase 
        options[:class] << 'moj-panel' 
        if i > 0 
          options[:title] = "Additional #{person.type.titleize}" 
          options[:show_remove_button] = true  
          options[:duplicate_address] = people.first.address.id  
          options[:not_the_first] = true 
        elsif person.full_name.blank? 
          options[:no_cancel] = true 
        end 
      
        editor_showing = true 
        
        return capture do
          render partial: 'people/edit', locals: {claim: claim, person: person, options: options}
        end

      else 
        options[:class] << "#{person.type.downcase}" 
        options[:show_edit_link] = true 
        return capture do
          render partial: 'people/show', locals: {claim: claim, person: person, options: options}
        end
      end 
    end 

    unless editor_showing || defined?(noadd) && noadd 
      return capture do
        render :partial => 'people/add', formats: [:html], :locals => {claim: @claim, person_type: person_type}
      end
    end 
  end
end