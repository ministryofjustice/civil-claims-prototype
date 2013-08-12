class AddressController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]

  def editor
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:person_id])
    address = Address.find(params[:id])

    address.show_editor = true

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, person: person, address: address, options: {}} }
    end
  end

  def hide_editor
    super(params[:id].to_i)
  end

  def copy_address_of_first
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:person_id])
    address = Address.find(params[:id])

    address_to_copy = claim.send(person.type.downcase.pluralize).first.address

    address.street_1 = address_to_copy[:street_1]
    address.street_2 = address_to_copy[:street_2]
    address.street_3 = address_to_copy[:street_3]
    address.town     = address_to_copy[:town]
    address.postcode = address_to_copy[:postcode]
    address.save

    options = {}
    options[:no_postcode_override] = true

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, person: person, address: address, options: options } }
    end    

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
