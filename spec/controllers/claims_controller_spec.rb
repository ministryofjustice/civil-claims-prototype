require 'spec_helper'

describe ClaimsController do
  context 'claims#create' do
    it 'should create a Claim' do
      assert_difference 'Claim.count' do
        session[:user] = Claimant.at_random.id
        post :create
      end

      assert_redirected_to personal_details_claim_path( assigns :claim )
    end
  end

  context 'claims#post_personal_details' do
    before :each do
      @claimant = Claimant.create(:address => Address.create)
      @defendant = Defendant.create(:address => Address.create)
      @property_address = Address.create

      @claim = Claim.create(:address => @property_address, :owner => @claimant)
      @claim.claimants << @claimant
      @claim.defendants << @defendant

      session[:bypass_auth] = true
      session[:referer] = 'personal_details'
    end

    context 'Save & Continue' do
      it 'should redirect to the next page in sequence' do
        patch :post_personal_details, id: @claim.id, commit: 'save-and-continue', claim: @claim.attributes
        assert_redirected_to case_details_claim_path( @claim )
      end
    end

    context 'Close' do
      it 'should redirect to the index page' do
        patch :post_personal_details, id: @claim.id, commit: 'close', claim: @claim.attributes
        assert_redirected_to root_path
      end
    end

    context 'Add another landlord' do
      it 'should add a claimant' do
        assert_difference( '@claim.claimants.count', +1 ) do
          patch :post_personal_details, id: @claim.id, commit: 'Add another landlord', claim: @claim.attributes
        end
      end
      it 'should stay on the personal_details page' do
        patch :post_personal_details, id: @claim.id, commit: 'Add another landlord', claim: @claim.attributes
        assert_redirected_to personal_details_claim_path @claim
      end
    end

    context 'Add another tenant' do
      it 'should add a defendant' do
        assert_difference( '@claim.defendants.count', +1 ) do
          patch :post_personal_details, id: @claim.id, commit: 'Add another tenant', claim: @claim.attributes
        end
      end
      it 'should stay on the personal_details page' do
        patch :post_personal_details, id: @claim.id, commit: 'Add another tenant', claim: @claim.attributes
        assert_redirected_to personal_details_claim_path @claim
      end
    end
  end

end