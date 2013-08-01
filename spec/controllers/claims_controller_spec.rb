require 'spec_helper'

describe ClaimsController do
  it 'homepage loads OK' do
    get :index
    assert_response :success
  end

  it 'should create a Claim' do
    assert_difference 'Claim.count' do
      post :create
    end

    assert_redirected_to claim_path( assigns :claim )
  end

end