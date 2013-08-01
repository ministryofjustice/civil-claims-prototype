class Address < ActiveRecord::Base
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
