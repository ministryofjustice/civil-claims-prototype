require 'spec_helper'

describe User do
  it 'selects a pre-seeded user at random' do
    user = User.at_random
    assert user.type == 'User'
  end

  it 'find all claims started by a user' do
    user = User.at_random

    assert user.claims.size == 0

    count = rand(1..10)
    count.times do 
      c = Claim.create
      c.owner = user
      c.save
    end

    assert user.claims.size == count
  end
end
