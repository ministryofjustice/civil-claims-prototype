module ClaimHelper
  def editing?( person, editors )
    #editors.has_key? person.id
    editors[person.id]
  end
end
