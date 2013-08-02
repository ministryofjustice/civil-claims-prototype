class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
  has_many :attachments

  belongs_to :address_for_possession, :class_name => 'Address'
  belongs_to :owner, :class_name => 'User'

end
