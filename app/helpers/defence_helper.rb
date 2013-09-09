module DefenceHelper

  def address_fields( address )
    capture do
      render partial: "addresses/address_for_possession/edit", locals: {address: address}
    end
  end

  def linkdata
    [
      { :text => 'Personal details', :path => 'personal_details' },
      { :text => 'About the case', :path => 'about_claim' },
      { :text => 'About you', :path => 'about_defence' },
      { :text => 'Preview and submit', :path => 'preview' },
      { :text => 'Confirmation', :path => 'confirmation' }
    ]
  end

end