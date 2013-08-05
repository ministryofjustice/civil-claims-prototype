class AddSignatureToClaim < ActiveRecord::Migration
  def change
    add_column :claims, :signature, :boolean
  end
end
