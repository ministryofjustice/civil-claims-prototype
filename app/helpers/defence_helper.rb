module DefenceHelper

  def address_fields( address )
    capture do
      render partial: "addresses/address_for_possession/edit", locals: {address: address}
    end
  end


end