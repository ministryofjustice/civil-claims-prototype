class AddSeededColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :seeded, :boolean, :default => false
  end
end
