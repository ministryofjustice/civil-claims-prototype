require 'spec_helper'

describe Person do
  it 'can be / has been seeded' do
    User.all.each do |u|
      assert u.class == User
    end
    assert User.all.count > 1
  end

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

  it 'is subclassed by User' do
    assert u = User.create(FactoryGirl.attributes_for :person)
    assert u.type == 'User'
  end
end
