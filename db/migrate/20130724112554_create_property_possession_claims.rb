class CreatePropertyPossessionClaims < ActiveRecord::Migration
  def change
    create_table :property_possession_claims do |t|

      t.timestamps
    end
  end
end
