class SetArrearsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :defenses, :arrears
    create_join_table :claims, :arrears

    remove_column :arrears, :claim_id
  end
end
