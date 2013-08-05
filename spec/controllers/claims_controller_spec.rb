require 'spec_helper'

describe ClaimsController do
  it 'should create a Claim' do
    assert_difference 'Claim.count' do
      session[:user] = Person.at_random.id
      pp Person.at_random
      post :create
    end

    assert_redirected_to claim_path( assigns :claim )
  end

end