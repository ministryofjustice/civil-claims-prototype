module AddressHelper
  def printAddressLine( lineitem )
    unless ( lineitem.nil? || lineitem.empty? )
      "<span class='address'>#{lineitem}</span>"
    else
      ''
    end
  end

  def generateAddresses( )
    addresses = options_for_select([
      ['Please select an address...'], 
      ['29 Alpacca Drive, Llamaville'], 
      ['31 Alpacca Drive, Llamaville'], 
      ['33 Alpacca Drive, Llamaville']
    ])
  end
end