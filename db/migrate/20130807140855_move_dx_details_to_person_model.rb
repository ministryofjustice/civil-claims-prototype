class MoveDxDetailsToPersonModel < ActiveRecord::Migration
  def change
    remove_column :addresses, :dx_number
    remove_column :addresses, :dx_exchange
  end
end
