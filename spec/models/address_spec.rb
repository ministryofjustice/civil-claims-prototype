require 'spec_helper'

describe Address do
  it 'set the :show_editor flag' do
    address = Address.create_random
    address.show_editor = 'show_editor'
    assert address.show_editor == 'show_editor'
  end
end
