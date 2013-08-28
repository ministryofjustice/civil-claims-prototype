class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
  has_many :attachments, :dependent => :destroy
  has_many :defenses, :dependent => :destroy
  has_and_belongs_to_many :arrears

  belongs_to :address_for_possession, :class_name => 'Address'
  belongs_to :owner, :class_name => 'Claimant'

  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :arrears, :allow_destroy => true



  def setup_linked_records( user )
    self.owner = user
    self.claimants << Claimant.new(user.attributes.except('type', 'id'))

    defendant = Defendant.new
    defendant.address = Address.new
    self.defendants << defendant

    self.address_for_possession = Address.new
  end
end
