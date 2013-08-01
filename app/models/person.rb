class Person < ActiveRecord::Base
  belongs_to :claim
  belongs_to :address

  def self.create_random
    self.create(generate)
  end

  def self.generate
    {
      :full_name  => "#{Random.firstname} #{Random.lastname}",
      :title      => %w(Mr Mrs Miss Ms Dr).sample,
      :phone      => Random.phone,
      :email      => Random.email,
      :address    => Address.create_random
    }
  end
end
