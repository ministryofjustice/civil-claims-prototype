class RemoveTitleColumnFromPersonModel < ActiveRecord::Migration
  def change
    remove_column :people, :title
  end
end
