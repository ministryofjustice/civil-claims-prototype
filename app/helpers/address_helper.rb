module AddressHelper
  def generate_random_addresses( postcode )
    addresses = [];
    15.times do
      a = Address.generate
      a[:postcode] = postcode unless postcode.blank?
      addresses << a
    end
    addresses
  end

  def defendant_addresses_for_journey
    street_addresses = [ 'Flat 1 92', 'Flat 2 92', 'Flat 3 92', 'Flat 4 92', 'Flat 5 92', 'Flat 6 92', 'Flat 7 92', 'Flat 8 92', 'Flat 9 92', 'Flat 10 92', 'Basement Flat 94', 'First Floor Flat 94', 'Ground Floor Flat 94', 'Top Flat 94', '96A', '96B', '96C', '96D', 'Flat 1 Park House 98-100', 'Flat 2 Park House 98-100', 'Flat 3 Park House 98-100', 'Flat 4 Park House 98-100', 'Flat 5 Park House 98-100', 'Flat 6 Park House 98-100', 'Flat 7 Park House 98-100', 'Flat 8 Park House 98-100', 'Flat 9 Park House 98-100', 'Flat 10 Park House 98-100', 'Flat 11 Park House 98-100', 'Flat 12 Park House 98-100', 'Flat 13 Park House 98-100', 'Flat 14 Park House 98-100', 'Flat 15 Park House 98-100', 'Flat 16 Park House 98-100', 'Flat 17 Park House 98-100', 'Flat 18 Park House 98-100', 'Flat 1 102', 'Flat 2 102', 'Flat 3 102', 'Flat 4 102', 'Flat 5 102', 'Flat 6 102', 'Flat A 104', 'Flat B 104', 'Flat C-I 104', 'Flat A 106', 'Flat B-H 106', '108A', '108B', '108C', 'Flat A-C 110', 'Garden Flat 110', 'Flat 1 112', 'Flat 2 112', 'Flat 3 112', 'Flat 4 112', 'Flat 5 112', 'Flat 1 114', 'Flat 2 114', 'Flat 3 114', 'Flat 4 114', 'Flat 5 114', 'Flat 6 114', 'Flat 7 114', 'Flat 8 114', '116A', '116B', '116C', '116D' ]
    town_address = { street_2: 'Crystal Palace Park Road', town: 'London', postcode: 'SE26 6UP' }

    journey_addresses = []
    street_addresses.each do |street|
      journey_addresses << { street_1: street }.merge(town_address)
    end

    journey_addresses
  end

  def please_select
    'Please select an address...'
  end

  def format_address_for_select( addresses ) 
    formatted_address_array = addresses.map do |ad| 
      addy = [ad[:street_1], ad[:street_2], ad[:street_3]].select { |x| !x.blank? }
      [addy.join(', '), {:'data-address' => ad.to_json}]
    end
    formatted_address_array.insert(0, [please_select])
    options_for_select formatted_address_array
  end
end