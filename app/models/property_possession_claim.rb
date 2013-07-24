class PropertyPossessionClaim < ActiveRecord::Base
	has_many :claimants
	has_many :defendants

	validates_presence_of :claimants
	validates_presence_of :defendants
end
