class Claim < ActiveRecord::Base
  has_many :claimants
  has_many :defendants
end
