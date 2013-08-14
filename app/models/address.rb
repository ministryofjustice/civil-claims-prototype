class Address < ActiveRecord::Base
  attr_accessor :show_editor

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
      :street_2   => Random.address_line_2,
      :postcode   => Random.uk_post_code,
      :town       => Random.city
    }
  end
end
