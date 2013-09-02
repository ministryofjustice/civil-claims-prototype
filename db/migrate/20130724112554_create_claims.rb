class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :property_type
      t.string :resident_type

      t.boolean :non_payment_of_rent
      t.boolean :anti_social_behaviour
      t.boolean :property_misuse
      t.boolean :other_breach_of_tenancy
      t.text :other_breach

      t.boolean :notice_to_quit
      t.date :notice_served_date
      t.boolean :lease_breach
      t.boolean :seeking_possetion
      t.boolean :other_recovery_steps_taken
      t.text :other_recovery_steps

      t.boolean :claim_rental_arrears
      t.boolean :lease_forfeiture
      t.boolean :includes_human_rights_issues

      t.string :tenancy_type
      t.date :tenancy_start_date
      t.decimal :rental_amount
      t.string :payment_frequency, :default => 'monthly'
      
      t.decimal :unpaid_rent_per_day
      t.boolean :defendent_to_pay_for_claim

      t.string :other_information

      t.references :address_for_possession
      t.references :owner

      t.timestamps
    end
  end
end
