require 'spec_helper'

describe Address do
  it 'set the :show_editor flag' do
    address = Address.create_random
    address.show_editor = 'show_editor'
    assert address.show_editor == 'show_editor'
  end

  it 'has a valid factory' do
    expect(create(:address)).to be_valid
  end

  context 'is valid when' do
    it 'has a real postcode' do
      expect(create(:address, postcode: 'n1 1dl')).to be_valid
    end

  end

  context 'is invalid when' do
  end
end
