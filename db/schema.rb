# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130828140636) do

  create_table "addresses", force: true do |t|
    t.string   "street_1"
    t.string   "street_2"
    t.string   "street_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arrears", force: true do |t|
    t.date     "due_date"
    t.decimal  "amount"
    t.decimal  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arrears_claims", id: false, force: true do |t|
    t.integer "claim_id",  null: false
    t.integer "arrear_id", null: false
  end

  create_table "arrears_defenses", id: false, force: true do |t|
    t.integer "defense_id", null: false
    t.integer "arrear_id",  null: false
  end

  create_table "attachments", force: true do |t|
    t.string   "file_name"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "claims", force: true do |t|
    t.string   "property_type"
    t.string   "resident_type"
    t.boolean  "non_payment_of_rent"
    t.boolean  "anti_social_behaviour"
    t.boolean  "property_misuse"
    t.boolean  "other_breach_of_tenancy"
    t.text     "other_breach"
    t.boolean  "notice_to_quit"
    t.date     "notice_served_date"
    t.boolean  "lease_breach"
    t.boolean  "seeking_possetion"
    t.boolean  "other_recovery_steps_taken"
    t.text     "other_recovery_steps"
    t.boolean  "claim_rental_arrears"
    t.boolean  "lease_forfeiture"
    t.boolean  "includes_human_rights_issues"
    t.string   "tenancy_type"
    t.date     "tenancy_start_date"
    t.decimal  "rental_amount"
    t.string   "payment_frequency",            default: "monthly"
    t.decimal  "unpaid_rent_per_day"
    t.boolean  "defendent_to_pay_for_claim"
    t.string   "other_information"
    t.integer  "address_for_possession_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "signature"
  end

  create_table "defenses", force: true do |t|
    t.integer  "claim_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "agree_with_tenancy_agreement_statement"
    t.text     "comments_on_tenancy_agreement_statement"
    t.boolean  "received_notice_to_quit"
    t.date     "date_received_notice_to_quit"
    t.boolean  "agree_with_rent_arrears"
    t.decimal  "statement_of_arrears"
    t.boolean  "paid_money_since_claim_brought"
    t.boolean  "agreement_to_repay_arrears"
    t.decimal  "repayment_amount"
    t.string   "repayment_frequency"
    t.boolean  "request_to_consider_repayments_by_installment"
    t.boolean  "has_claim_against_landlord"
    t.string   "claim_case_number"
    t.text     "comments_on_particulars"
    t.decimal  "current_account_balance"
    t.boolean  "dont_have_current_account"
    t.decimal  "savings_account_balance"
    t.boolean  "dont_have_savings_account"
    t.boolean  "employed"
    t.boolean  "universal_credit"
    t.decimal  "income"
    t.decimal  "pension"
    t.decimal  "child_benefit"
    t.decimal  "other_monies_in"
    t.boolean  "in_arrears_in_monthly_outgoings"
    t.boolean  "loans_or_credit_cards"
    t.boolean  "loans_arrears"
    t.text     "loans_arrears_details"
    t.boolean  "currently_paying_court_orders_or_fines"
    t.boolean  "behind_on_fine_payments"
    t.text     "fine_payments_details"
    t.boolean  "has_dependent_children"
    t.integer  "dependents_under_11",                           default: 0
    t.integer  "dependents_11_to_15",                           default: 0
    t.integer  "dependents_16_to_17",                           default: 0
    t.integer  "dependents_18_and_over",                        default: 0
    t.boolean  "has_other_dependents"
    t.text     "details_of_other_dependents"
    t.text     "details_of_circumstances"
    t.boolean  "has_somewhere_else_to_live"
    t.date     "move_in_date_for_other_property"
  end

  create_table "grounds_for_possession_answers", force: true do |t|
    t.boolean  "non_payment_of_rent"
    t.boolean  "anti_social_behaviour"
    t.boolean  "misuse_of_property"
    t.boolean  "other"
    t.string   "please_specify"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthly_expenses", force: true do |t|
    t.string  "name"
    t.decimal "amount"
    t.integer "defense_id"
  end

  create_table "monthly_payments", force: true do |t|
    t.string  "reference"
    t.decimal "balance"
    t.decimal "cost_per_month"
    t.integer "defense_id"
  end

  create_table "people", force: true do |t|
    t.string   "title"
    t.string   "full_name"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "type"
    t.integer  "address_id"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dx_number"
    t.string   "dx_exchange"
    t.boolean  "seeded",      default: false
  end

  create_table "steps_already_taken_answers", force: true do |t|
    t.boolean  "notice_to_quit"
    t.datetime "date_notice_served"
    t.boolean  "breach_of_lease"
    t.boolean  "seeking_possession"
    t.boolean  "other"
    t.string   "other_recovery_steps_taken"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
