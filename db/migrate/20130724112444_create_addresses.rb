class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :dx_number
      t.string :dx_exchange
      t.string :street_1
      t.string :street_2
      t.string :street_3
      t.string :town
      t.string :county
      t.string :postcode

      t.timestamps
    end
  end
end
