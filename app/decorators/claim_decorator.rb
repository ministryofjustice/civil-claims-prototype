class ClaimDecorator < Draper::Decorator
  delegate_all
  decorates_association :claimants
  decorates_association :defendants

end
