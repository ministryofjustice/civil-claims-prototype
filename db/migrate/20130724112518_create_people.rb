class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :title
      t.string :full_name
      t.string :phone
      t.string :mobile
      t.string :email

      t.string :dx_number
      t.string :dx_exchange
      t.string :street_1
      t.string :street_2
      t.string :street_3
      t.string :town
      t.string :county
      t.string :postcode

      t.string :type
      t.references :claim
      t.timestamps
    end
  end
end
