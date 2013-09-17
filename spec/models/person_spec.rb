require 'spec_helper'

describe Person do
  it 'can be factory generated' do
    assert FactoryGirl.create(:person)
  end

  it 'can be randomly generated' do
    assert Person.create_random
  end

  it 'is subclassed by Claimant' do
    assert c = Claimant.create(FactoryGirl.attributes_for :person)
    assert c.type == 'Claimant'
  end

  it 'is subclassed by Defendant' do
    assert d = Defendant.create(FactoryGirl.attributes_for :person)
    assert d.type == 'Defendant'
  end

  it 'is subclassed by Judge' do
    assert u = Judge.create(FactoryGirl.attributes_for :person)
    assert u.type == 'Judge'
  end

  it 'selects a pre-seeded user at random' do
    user = Claimant.at_random
    assert user.type == 'Claimant'
  end

  it 'find all claims started by a user' do
    user = Claimant.at_random

    assert user.claims.size == 0

    count = rand(1..10)
    count.times do
      c = Claim.create
      c.owner = user
      c.save
    end

    assert user.claims.size == count
  end

  it 'finds a preseeded UserJourney person' do
    user = Claimant.find_by :uj => true
    assert user.type == 'Claimant'
  end

  it 'should create deep duplicate of itself' do
    source_person = Person.first
    sut_person = source_person.deep_dup

    assert sut_person
    assert sut_person.address

    expect(sut_person.id).to_not eq(source_person.id)
    expect(sut_person.full_name).to eq(source_person.full_name)

    expect(sut_person.address.id).to_not eq(source_person.address.id)
    expect(sut_person.address.street_1).to eq(source_person.address.street_1)
  end
end
