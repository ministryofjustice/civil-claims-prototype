require 'spec_helper'

describe Claim do
  before :each do
    @claim = Claim.new
  end

  it 'has an owner' do
    @claim.owner = Claimant.create_random
    assert @claim.save
  end

  it 'has 0 or more claimants' do
    assert @claim.claimants.empty?
    assert @claim.claimants << Claimant.create_random
    assert @claim.claimants.size == 1
    assert @claim.save
  end

  it 'has 0 or more defendants' do
    assert @claim.defendants << Defendant.create_random
    assert @claim.defendants << Defendant.create_random
    assert @claim.defendants.size == 2
    assert @claim.save
  end

  it 'has an address for repossession' do
    @claim.address_for_possession = Address.create_random
    assert @claim.save
  end

  it 'landlord can attach arrears' do
    assert @claim.arrears << Arrear.create
    assert @claim.save
    assert @claim.arrears.size == 1
  end

  it 'can have multiple defenses' do
    assert @claim.defenses << Defense.create
    assert @claim.save
    assert @claim.defenses.size == 1
  end
end
