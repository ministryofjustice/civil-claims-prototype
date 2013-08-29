class Address < ActiveRecord::Base
  attr_accessor :show_editor

  def full_address
    %w(street_1 street_2 street_3 town postcode).reject{|x| self.send(x).blank? }.map {|x| self.send(x) }
  end

  def copy_from address_to_copy_from
    self.street_1 = address_to_copy_from[:street_1]
    self.street_2 = address_to_copy_from[:street_2]
    self.street_3 = address_to_copy_from[:street_3]
    self.town     = address_to_copy_from[:town]
    self.postcode = address_to_copy_from[:postcode]
    self.save
  end

  def self.create_random
    self.create(generate)
  end

  def self.generate()

    address = {
      :street_1   => Random.address_line_1,
      :postcode   => Random.uk_post_code,
      :town       => Random.city
    }

    i = rand
    if i > 0.6
      address[:street_3] = Random.address_line_2
    elsif i > 0.2
      address[:street_2] = Random.address_line_2
    else
      address[:street_2] = Random.address_line_2
      address[:street_3] = Random.address_line_2
    end
    address[:county] = random_county if rand > 0.3
    address
  end

  def self.random_county
    uk_county_arrray = ['Bedfordshire', 'Berkshire', 'Bristol', 'Buckinghamshire', 'Cambridgeshire', 'Cheshire', 'City of London', 'Cornwall', 'Cumbria', 'Derbyshire', 'Devon', 'Dorset', 'Durham', 'East Riding of Yorkshire', 'East Sussex', 'Essex', 'Gloucestershire', 'Greater London', 'Greater Manchester', 'Hampshire', 'Herefordshire', 'Hertfordshire', 'Isle of Wight', 'Kent', 'Lancashire', 'Leicestershire', 'Lincolnshire', 'Merseyside', 'Norfolk', 'North Yorkshire', 'Northamptonshire', 'Northumberland', 'Nottinghamshire', 'Oxfordshire', 'Rutland', 'Shropshire', 'Somerset', 'South Yorkshire', 'Staffordshire', 'Suffolk', 'Surrey', 'Tyne and Wear', 'Warwickshire', 'West Midlands', 'West Sussex', 'West Yorkshire', 'Wiltshire', 'Worcestershire', 'Anglesey', 'Brecknockshire', 'Caernarfonshire', 'Carmarthenshire', 'Cardiganshire', 'Denbighshire', 'Flintshire', 'Glamorgan', 'Merioneth', 'Monmouthshire', 'Montgomeryshire', 'Pembrokeshire', 'Radnorshire', 'Aberdeenshire', 'Angus', 'Argyllshire', 'Ayrshire', 'Banffshire', 'Berwickshire', 'Buteshire', 'Cromartyshire', 'Caithness', 'Clackmannanshire', 'Dumfriesshire', 'Dunbartonshire', 'East Lothian', 'Fife', 'Inverness-shire', 'Kincardineshire', 'Kinross', 'Kirkcudbrightshire', 'Lanarkshire', 'Midlothian', 'Morayshire', 'Nairnshire', 'Orkney', 'Peeblesshire', 'Perthshire', 'Renfrewshire', 'Ross-shire', 'Roxburghshire', 'Selkirkshire', 'Shetland', 'Stirlingshire', 'Sutherland', 'West Lothian', 'Wigtownshire', 'Antrim', 'Armagh', 'Down', 'Fermanagh', 'Londonderry', 'Tyrone' ]
    uk_county_arrray.sample
  end
end
