class Person < ActiveRecord::Base
	has_one :address

  validate :has_address

  def has_address
    errors.add(:base, "Person must have an address") unless address_id.present?
  end
end
