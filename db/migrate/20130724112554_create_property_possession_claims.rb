class CreatePropertyPossessionClaims < ActiveRecord::Migration
  def change
    create_table :property_possession_claims do |t|
      t.timestamps
    end

    create_join_table :property_possession_claims, :claimants
    create_join_table :property_possession_claims, :defendants
  end
end
