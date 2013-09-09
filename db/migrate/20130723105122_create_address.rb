class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_1
      t.string :street_2
      t.string :street_3
      t.string :town
      t.string :county
      t.string :postcode
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
