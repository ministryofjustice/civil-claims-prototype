class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
  has_many :attachments, :dependent => :destroy
  has_many :arrears, :dependent => :destroy

  belongs_to :address_for_possession, :class_name => 'Address'
  belongs_to :owner, :class_name => 'Person'

  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :arrears, :allow_destroy => true


  def setup_linked_records( user )
    self.owner = user
    self.claimants << Claimant.new(user.attributes.except('type', 'id'))

    defendant = Defendant.new
    defendant.address = Address.new
    self.defendants << defendant
  end
end
