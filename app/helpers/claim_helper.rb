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
end
