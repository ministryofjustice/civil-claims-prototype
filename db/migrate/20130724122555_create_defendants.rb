class CreateDefendants < ActiveRecord::Migration
  def change
    create_table :defendants do |t|
      t.references :person
      t.references :claim
      t.timestamps
    end
  end
end