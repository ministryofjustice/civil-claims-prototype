class CreateDefense < ActiveRecord::Migration
  def change
    create_table :defenses do |t|
      t.references :claim
      t.references :owner
      t.timestamps

      # About the Claim

      t.boolean :agree_with_tenancy_agreement_statement
      t.text    :comments_on_tenancy_agreement_statement

      t.boolean :received_notice_to_quit
      t.date    :date_received_notice_to_quit

      t.boolean :agree_with_rent_arrears
      t.decimal :statement_of_arrears

      t.boolean :paid_money_since_claim_brought

      t.boolean :agreement_to_repay_arrears
      t.decimal :repayment_amount
      t.string  :repayment_frequency
      t.boolean :request_to_consider_repayments_by_installment
      t.decimal :installment_amount
      t.string  :installment_frequency

      t.boolean :has_claim_against_landlord
      t.string  :claim_case_number

      t.text    :comments_on_particulars

      # About The Tenant

      t.decimal :current_account_balance
      t.boolean :dont_have_current_account

      t.decimal :savings_account_balance
      t.boolean :dont_have_savings_account

      # money in
      t.string :present_circumstances
      t.string :no_income_details

      t.decimal :income
      t.decimal :pension
      t.decimal :child_benefit
      t.decimal :other_monies_in

      # money out

      # ref monthly expenses
      t.boolean :in_arrears_in_monthly_outgoings
      # ref monthly payments
      
      t.boolean :loans_or_credit_cards
      # ref monthly payments
      t.boolean :loans_arrears
      t.text    :loans_arrears_details

      t.boolean :currently_paying_court_orders_or_fines
      # ref monthly payments
      t.boolean :behind_on_fine_payments
      t.text    :fine_payments_details

      # Dependents

      t.boolean :has_dependent_children
      t.integer :dependents_under_11, :default => 0
      t.integer :dependents_11_to_15, :default => 0
      t.integer :dependents_16_to_17, :default => 0
      t.integer :dependents_18_and_over, :default => 0

      t.boolean :has_other_dependents
      t.text :details_of_other_dependents

      # Circumstances

      t.text :details_of_circumstances
      t.boolean :has_somewhere_else_to_live
      t.date :move_in_date_for_other_property

    end

  end
end
