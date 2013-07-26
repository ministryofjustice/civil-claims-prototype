require 'spec_helper'

describe Claimant do
  it 'instantiates' do
    claimant = Claimant.new(attributes_for :person)
    assert claimant.save
  end
end
