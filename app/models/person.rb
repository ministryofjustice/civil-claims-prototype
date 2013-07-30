class Person < ActiveRecord::Base
  has_one :claim

  def self.generate
    {
      :full_name  => "#{Random.firstname} #{Random.lastname}",
      :title      => %w(Mr Mrs Miss Ms Dr).sample,
      :phone      => Random.phone,
      :email      => Random.email,
      :street_1   => Random.address_line_1,
      :street_2   => Random.address_line_2,
      :postcode   => Random.uk_post_code,
      :town       => Random.city
    }
  end
end
