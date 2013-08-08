module AddressHelper
  def printAddressLine( lineitem )
    unless ( lineitem.nil? || lineitem.empty? )
      "<span class='address'>#{lineitem}</span>"
    else
      ''
    end
  end
end