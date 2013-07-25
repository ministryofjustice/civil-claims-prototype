class CreateClaimants < ActiveRecord::Migration
  def change
    create_table :claimants do |t|
      t.references :person
      t.references :claim
      t.timestamps
    end
  end
end