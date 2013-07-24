class CreateClaimants < ActiveRecord::Migration
  def change
    create_table :claimants do |t|

      t.timestamps
    end
  end
end
