class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :title
      t.string :full_name
      t.string :phone
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
