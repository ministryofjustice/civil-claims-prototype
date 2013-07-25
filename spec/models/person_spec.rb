require 'spec_helper'

describe Person do
  it 'requires an address' do
    person = build(:person)
    person.address_id = nil
    assert !person.save

    address = create(:address)
    person.address_id = address.id
    assert person.save
  end
end
