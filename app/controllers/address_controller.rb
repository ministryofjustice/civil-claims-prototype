class AddressController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]

  def editor
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:person_id])
    address = Address.find(params[:id])

    address.show_editor = true

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, person: person, address: address} }
    end
  end

  def hide_editor
    super(params[:id].to_i)
  end


  def picker
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:person_id])
    address = Address.find(params[:id])

    respond_to do |format|
      format.js { render :partial => 'addresses/picker', :locals => {address: address} }
    end
  end

  def random
    address = Address.generate
    respond_to do |format|
      format.json { render :json => address.to_json }
    end
  end

end
