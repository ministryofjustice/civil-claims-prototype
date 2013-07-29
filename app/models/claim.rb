class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants

  belongs_to :user

  def user=(owner)
    self.person_id = owner.id
  end
end
