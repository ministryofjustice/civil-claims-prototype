class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :title
      t.string :full_name
      t.string :phone
      t.string :mobile
      t.string :email

      t.string :type
      t.references :address
      t.references :claim
      t.timestamps
    end
  end
end
