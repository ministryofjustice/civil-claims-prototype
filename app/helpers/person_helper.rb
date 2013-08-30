module PersonHelper
  def display_landlords( claim )
    display( claim, 'claimant' )
  end

  def display_tenants( claim )
    display( claim, 'defendant' )
  end


  def display(claim, person_type)
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
        
        concat( render partial: 'people/edit', locals: {claim: claim, person: person, options: options} )

      else 
        options[:class] << "#{person.type.downcase}" 
        options[:show_edit_link] = true 
        concat( render partial: 'people/show', locals: {claim: claim, person: person, options: options} )
      end 
    end 

    unless editor_showing || defined?(noadd) && noadd 
      concat( render :partial => 'people/add', formats: [:html], :locals => {claim: @claim, person_type: person_type} )
    end 
  end
end