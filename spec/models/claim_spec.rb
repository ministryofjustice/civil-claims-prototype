require 'spec_helper'

describe Claim do
  it 'can add claimants' do
    claim = Claim.new
    claim.save

    person = create(:person)
    claim.claimants.create(:person_id => person.id)
    person2 = create(:person)
    claim.claimants.create(:person_id => person2.id)

    assert claim.claimants.count == 2
    assert claim.save
  end

end
