class CreateDefendants < ActiveRecord::Migration
  def change
    create_table :defendants do |t|

      t.timestamps
    end
  end
end
