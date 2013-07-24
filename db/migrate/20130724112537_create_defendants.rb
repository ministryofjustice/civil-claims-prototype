class CreateDefendants < ActiveRecord::Migration
  def change
    create_table :defendants do |t|
      t.references :person
      t.timestamps
    end
  end
end
