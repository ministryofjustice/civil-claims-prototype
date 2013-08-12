module AddressHelper
  def printAddressLine( lineitem )
    unless ( lineitem.nil? || lineitem.empty? )
      "<span class='address'>#{lineitem}</span>"
    else
      ''
    end
  end

  def generateAddresses( )
    addresses = [['Please select an address...']];
    5.times do
      a = Address.generate
      addresses << [a[:street_1] + ', ' + a[:town]];
    end
    options_for_select(addresses)
  end
end