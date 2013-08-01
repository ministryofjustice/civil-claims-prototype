class CreateGroundsForPossession < ActiveRecord::Migration
  def change
    create_table :grounds_for_possession_answers do |t|
      t.boolean :non_payment_of_rent
      t.boolean :anti_social_behaviour
      t.boolean :misuse_of_property
      t.boolean :other
      t.string :please_specify


      t.references :claim
      t.timestamps
    end
  end
end
