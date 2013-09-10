require 'spec_helper'

describe Claimant do
  it 'has a valid factory' do
    expect(create(:claimant)).to be_valid
  end

  context 'is valid when' do
    it 'full_name >= 5 characters' do
      expect( create(:claimant, full_name: '12345')).to be_valid
    end

    it 'phone number is blank' do
      expect( create(:claimant, phone: nil)).to be_valid
    end

    it 'phone number contains only chars 0-9 () - +' do
      expect( create(:claimant, phone: '+123 (0) 123--123')).to be_valid
    end

    it 'mobile number is blank' do
      expect( create(:claimant, mobile: nil)).to be_valid
    end

    it 'email address is blank' do
      expect( create(:claimant, email: nil)).to be_valid
    end

    it 'email address is well formed' do
      expect( create(:claimant, email: 'text@domain')).to be_valid
    end
  end

  context 'is invalid when', :if => false do
      
    it 'full_name missing' do
      expect(build(:claimant, full_name: nil)).to have_at_least(1).errors_on(:full_name) 
    end

    it 'full_name < 5 characters' do
      expect(build(:claimant, full_name: '1234')).to have(1).errors_on(:full_name)
    end

    it 'phone number contains alphabetics' do
      expect(build(:claimant, phone: '123x123')).to have(1).errors_on(:phone)
    end

    it 'email address is poorly formed' do
      expect( build(:claimant, email: 'wrong')).to have(1).errors_on(:email)
    end
  end
end
