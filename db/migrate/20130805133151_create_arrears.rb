class CreateArrears < ActiveRecord::Migration
  def change
    create_table :arrears do |t|
      t.date :due_date
      t.decimal :amount
      t.decimal :paid
      t.integer :claim_id
      
      t.timestamps
    end
  end
end
