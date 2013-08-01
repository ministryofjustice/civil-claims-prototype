class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants

  belongs_to :address_for_possession, :class_name => 'Address'
  belongs_to :owner, :class_name => 'User'

end
