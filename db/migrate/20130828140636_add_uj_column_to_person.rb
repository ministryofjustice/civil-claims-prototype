class AddUjColumnToPerson < ActiveRecord::Migration
  def change
    add_column :people, :uj, :boolean, :default => false
  end
end
