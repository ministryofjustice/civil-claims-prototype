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

      t.string :type
      t.references :claim
      t.timestamps
    end
  end
end
