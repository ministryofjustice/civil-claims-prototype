class CreateMonthlyPayments < ActiveRecord::Migration
  def change
    create_table :monthly_payments do |t|
      t.string :reference
      t.decimal :balance
      t.decimal :cost_per_month

      t.references :defense
    end
  end
end
