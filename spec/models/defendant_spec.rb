require 'spec_helper'

describe Defendant do
  it 'has a valid factory' do
    expect(create(:defendant)).to be_valid
  end

  context 'is valid when' do
    it 'full_name >= 5 characters' do
      expect( create(:defendant, full_name: '12345')).to be_valid
    end

    it 'phone number is blank' do
      expect( create(:defendant, phone: nil)).to be_valid
    end

    it 'phone number contains only chars 0-9 () - +' do
      expect( create(:defendant, phone: '+123 (0) 123--123')).to be_valid
    end

    it 'mobile number is blank' do
      expect( create(:defendant, mobile: nil)).to be_valid
    end

    it 'email address is blank' do
      expect( create(:defendant, email: nil)).to be_valid
    end

    it 'email address is well formed' do
      expect( create(:defendant, email: 'text@domain')).to be_valid
    end

    it 'has an address' do
      expect(create(:defendant).address).to_not be_nil
    end
  end

end
