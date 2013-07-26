require 'spec_helper'

describe Person do
  it 'instantiates' do
    person = build(:person)
    assert person.save
  end
end
