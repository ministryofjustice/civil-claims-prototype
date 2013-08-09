require 'spec_helper'

describe PeopleController do
  it 'toggles editor visibility' do
    person = Claimant.create_random
    claim = Claim.create
    claim.claimants << person
    session[:bypass_auth] = true
    session['editors'] = {person.id => false}
    get(:editor, {'id' => person.id, 'claim_id' => claim.id})
    assert session['editors'][person.id] == true
  end

end