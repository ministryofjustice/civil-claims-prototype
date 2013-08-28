class CreateMonthlyExpense < ActiveRecord::Migration
  def change
    create_table :monthly_expenses do |t|
      t.string :name
      t.decimal :amount

      t.references :defense
    end
  end
end
