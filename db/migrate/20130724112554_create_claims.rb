class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :property_type
      t.string :resident_type

      t.date :rent_due_date
      t.decimal :contributions_this_month
      
      t.decimal :unpaid_rent_per_day
      t.boolean :defendent_to_pay_for_claim

      t.string :other_information

      t.references :address_for_possession
      t.references :owner

      t.timestamps
    end
  end
end
