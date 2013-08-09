module AddressHelper
  def printAddressLine( lineitem )
    unless ( lineitem.nil? || lineitem.empty? )
      "<span class='address'>#{lineitem}</span>"
    else
      ''
    end
  end

  def generateAddresses( )
    addresses = options_for_select([['Please select an address...', 0], ['one', 1], ['two', 2], ['three', 3]], 0)
  end
end