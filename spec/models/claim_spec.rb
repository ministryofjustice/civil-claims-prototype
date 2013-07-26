require 'spec_helper'

describe Claim do
  it 'can add claimants' do
    claim = Claim.new
    claim.save

    claimant = Claimant.new(attributes_for :person)
    claimant.save
    claim.claimants << claimant

    assert claim.claimants.count == 1

    assert claim.save
  end

end
