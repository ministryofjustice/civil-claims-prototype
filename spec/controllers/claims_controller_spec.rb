require 'spec_helper'

describe ClaimsController do
  context 'claims#create' do
    it 'should create a Claim' do
      assert_difference 'Claim.count' do
        session[:user] = Claimant.at_random.id
        post :create
      end

      assert_redirected_to claim_path( assigns :claim )
    end
  end

  context 'claims#post_personal_details' do
    before :each do
      @claim = Claim.create
      session[:bypass_auth] = true
      session[:referer] = 'personal_details'
      @method = :post_personal_details
    end

    context 'Save & Continue' do
      it 'should redirect to the next page in sequence' do
        patch @method, id: @claim.id, commit: 'Save & Continue'
        assert_redirected_to case_details_claim_path( @claim )
      end
    end

    context 'Close' do
      it 'should redirect to the index page' do
        patch @method, id: @claim.id, commit: 'Close'
        assert_redirected_to root_path
      end
    end

    context 'Add another landlord' do
      it 'should add a claimant' do
        assert_difference( '@claim.claimants.count', +1 ) do
          patch @method, commit: 'Add another landlord'
        end
      end
      it 'should render the personal_details page' do
        patch @method, commit: 'Add another landlord'
        assert_redirected_to @claim
      end
    end

    context 'Add another tenant' do
      it 'should add a defendant' do
        assert_difference( '@claim.defendants.count', +1 ) do
          patch @method, commit: 'Add another tenant'
        end
      end
      it 'should render the personal_details page' do
        patch @method, commit: 'Add another tenant'
        assert_redirected_to @claim
      end
    end
  end

end