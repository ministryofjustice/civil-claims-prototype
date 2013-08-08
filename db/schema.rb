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

ActiveRecord::Schema.define(version: 20130807140855) do

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

  create_table "attachments", force: true do |t|
    t.string   "file_name"
    t.integer  "claim_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "claims", force: true do |t|
    t.string   "property_type"
    t.string   "resident_type"
    t.integer  "address_for_possession_id"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "signature"
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
