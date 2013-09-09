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
    @claim.create_address Address.generate
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
  
  context 'when creating claim as per user story (create_as_per_user_journey)' do
    it 'can build a claim as per the user journey' do
      @claim.create_as_per_user_journey
      assert @claim.save
    end

    it 'should assign owner of the claim' do
      @claim.create_as_per_user_journey
      sut_owner = @claim.owner

      assert sut_owner
      assert sut_owner.id
      sut_owner.full_name.should eq 'John Smith Reynolds'
      sut_owner.address.street_1.should eq '121 Elm Park Road'
      sut_owner.address.town.should eq 'London'
      sut_owner.address.postcode.should eq 'SW1 1SZ'
    end

    it 'should assign primary claimant and their address' do
      @claim.create_as_per_user_journey

      @claim.claimants.should_not be_empty
      sut_claimant = @claim.claimants.first

      assert sut_claimant.id
      sut_claimant.full_name.should eq 'John Smith Reynolds'
      sut_claimant.address.street_1.should eq '121 Elm Park Road'
      sut_claimant.address.street_2.should be_blank
      sut_claimant.address.street_3.should be_blank
      sut_claimant.address.town.should eq 'London'
      sut_claimant.address.postcode.should eq 'SW1 1SZ'
    end

    it 'should assign primary defendant and their address' do
      @claim.create_as_per_user_journey

      @claim.defendants.should_not be_empty
      sut_defendant = @claim.defendants.first

      assert sut_defendant.id
      sut_defendant.full_name.should eq 'Louis Robert Stevenson'
      test_defendant_address sut_defendant.address
    end

    it 'should assign apartment address to be the same as primary defendant' do
      @claim.create_as_per_user_journey

      @claim.defendants.should_not be_empty
      sut_address = @claim.address
      assert sut_address.id
      test_defendant_address sut_address
    end

    private 
      def test_defendant_address (sut_address)
        sut_address.street_1.should eq 'Flat 3'
        sut_address.street_2.should eq '92 Crystal Palace Park Road'
        sut_address.street_3.should be_blank
        sut_address.town.should eq 'London'
        sut_address.postcode.should eq 'SE26 6UP'
      end

  end

end
