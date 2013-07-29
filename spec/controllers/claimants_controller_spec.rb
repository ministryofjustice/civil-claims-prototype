require 'spec_helper'

describe ClaimantsController do

  describe 'POST create' do
    it 'creates a new resource' do
      claim = Claim.new
      claim.save

      cl = FactoryGirl.attributes_for(:person)
      post "/claim/#{claim.id}/claimants", :claimant => cl

      assert_response :found

    end
  end
end