class AddressController < ApplicationController
  skip_before_action :pretend_to_authenticate, only: [:login]

  def editor
    claim = Claim.find(params[:claim_id])
    address = Address.find(params[:id])

    address.show_editor = true

    respond_to do |format|
      format.html { redirect_to claim_path claim }

      if params.has_key? :person_id
        person = Person.find(params[:person_id]) 
        options = { :just_the_address_fields => true }
        format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, person: person, address: address, options: options } }
      elsif claim.address_for_possession.id == address.id
        format.js { render :partial => 'addresses/edit_address_for_possession', :formats => [:js], :locals => {claim:claim, address:address} }  
      else
        format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, address: address, options: {}} }
      end
    end
  end

  def hide_editor
    super(params[:id].to_i)
  end

  def copy_address_of_first
    claim = Claim.find(params[:claim_id])
    person = Person.find(params[:person_id])
    address = Address.find(params[:id])

    address.copy_from claim.send(person.type.downcase.pluralize).first.address

    options = { 
      :no_postcode_override => true,
      :just_the_address_fields => true
    }

    respond_to do |format|
      format.html { redirect_to claim_path claim }
      format.js { render :partial => 'addresses/edit', :formats => [:js], :locals => {claim: claim, person: person, address: address, options: options } }
    end    

  end

  def picker
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
