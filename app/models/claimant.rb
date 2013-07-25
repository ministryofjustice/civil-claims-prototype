class Claimant < ActiveRecord::Base
  has_one :person
  has_one :claim
end
