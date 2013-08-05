class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
  has_many :attachments, :dependent => :destroy
  has_many :arrears, :dependent => :destroy

  belongs_to :address_for_possession, :class_name => 'Address'
  belongs_to :owner, :class_name => 'User'

  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :arrears, :allow_destroy => true

end
