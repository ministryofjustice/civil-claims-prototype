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

ActiveRecord::Schema.define(version: 20130724112554) do

  create_table "addresses", force: true do |t|
    t.string   "dx_number"
    t.string   "dx_exchange"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "street_3"
    t.string   "town"
    t.string   "county"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "claimants", force: true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "claimants_property_possession_claims", id: false, force: true do |t|
    t.integer "property_possession_claim_id", null: false
    t.integer "claimant_id",                  null: false
  end

  create_table "defendants", force: true do |t|
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "defendants_property_possession_claims", id: false, force: true do |t|
    t.integer "property_possession_claim_id", null: false
    t.integer "defendant_id",                 null: false
  end

  create_table "people", force: true do |t|
    t.string   "title"
    t.string   "full_name"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_possession_claims", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
