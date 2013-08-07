class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :property_type
      t.string :resident_type

      t.date :rent_due_date
      t.decimal :contributions_this_month

      t.references :address_for_possession
      t.references :owner

      t.timestamps
    end
  end
end
