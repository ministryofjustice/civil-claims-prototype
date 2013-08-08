class MoveDxDetailsToPersonModel < ActiveRecord::Migration
  def change
    add_column :people, :dx_number, :string
    add_column :people, :dx_exchange, :string

    remove_column :addresses, :dx_number
    remove_column :addresses, :dx_exchange
  end
end
