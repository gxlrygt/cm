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

ActiveRecord::Schema.define(version: 20151031190118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "broker_approval_forms", force: :cascade do |t|
    t.text     "company",                                    null: false
    t.string   "company_type",                               null: false
    t.string   "dba"
    t.string   "company_president",                          null: false
    t.string   "broker_of_record",                           null: false
    t.string   "nmls",                                       null: false
    t.string   "address",                                    null: false
    t.string   "city",                                       null: false
    t.integer  "state_id",                                   null: false
    t.string   "zip",                                        null: false
    t.string   "primary_contact",                            null: false
    t.string   "title",                                      null: false
    t.string   "phone"
    t.text     "how_did_you_find_us",                        null: false
    t.text     "how_did_you_find_us_account_executive_name"
    t.text     "how_did_you_find_us_other"
    t.string   "lender_paid_compensation_percentage",        null: false
    t.string   "maximum_compensation",                       null: false
    t.string   "user"
    t.string   "role"
    t.text     "email"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "broker_approval_forms_loan_types", force: :cascade do |t|
    t.integer "broker_approval_form_id"
    t.integer "loan_type_id"
  end

  add_index "broker_approval_forms_loan_types", ["broker_approval_form_id", "loan_type_id"], name: "index_baf_loan_types_name", using: :btree

  create_table "contact_forms", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "company"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "regarding"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "external_site_passwords", force: :cascade do |t|
    t.string   "external_site", null: false
    t.text     "password"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "external_site_passwords", ["user_id"], name: "index_external_site_passwords_on_user_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string "first_name", limit: 255, null: false
    t.string "last_name",  limit: 255, null: false
    t.string "email",      limit: 255, null: false
    t.string "phone",      limit: 255
  end

  create_table "loan_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "loans", force: :cascade do |t|
    t.string   "account_executive"
    t.string   "lender_or_borrower_paid"
    t.boolean  "underwriting_fee_buyout"
    t.string   "lender_compensation"
    t.string   "broker_first_name"
    t.string   "broker_last_name"
    t.string   "broker_phone"
    t.string   "broker_email"
    t.string   "processor_first_name"
    t.string   "processor_last_name"
    t.string   "processor_phone"
    t.string   "processor_email"
    t.text     "address"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip"
    t.string   "borrower_first_name"
    t.string   "borrower_last_name"
    t.string   "borrower_email"
    t.string   "borrower_mid_fico_score"
    t.string   "coborrower_first_name"
    t.string   "coborrower_last_name"
    t.string   "coborrower_email"
    t.string   "coborrower_mid_fico_score"
    t.decimal  "property_value",             precision: 15, scale: 4
    t.decimal  "loan_amount",                precision: 15, scale: 4
    t.decimal  "disclosed_rate_pct",         precision: 15, scale: 4
    t.string   "ltv"
    t.string   "cltv"
    t.boolean  "impounds_or_escrows"
    t.string   "loan_type"
    t.string   "transaction_type"
    t.string   "fha_underwriting_type"
    t.string   "term"
    t.string   "property_type"
    t.boolean  "appraisal_needed"
    t.string   "occupancy"
    t.text     "additional_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gfe_file_file_name"
    t.string   "gfe_file_content_type"
    t.integer  "gfe_file_file_size"
    t.datetime "gfe_file_updated_at"
    t.string   "fee_worksheet_file_name"
    t.string   "fee_worksheet_content_type"
    t.integer  "fee_worksheet_file_size"
    t.datetime "fee_worksheet_updated_at"
    t.string   "borrower_phone"
    t.string   "coborrower_phone"
  end

  create_table "products", force: :cascade do |t|
    t.text     "name",        null: false
    t.string   "category"
    t.string   "subcategory"
    t.text     "description"
    t.text     "table_html",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "iframe_url"
  end

  add_index "products", ["category"], name: "index_products_on_category", using: :btree
  add_index "products", ["subcategory"], name: "index_products_on_subcategory", using: :btree

  create_table "states", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
  end

  add_index "states", ["code"], name: "index_states_on_code", unique: true, using: :btree

  create_table "tpo_user_access_requests", force: :cascade do |t|
    t.string   "first_name",              null: false
    t.string   "last_name",               null: false
    t.string   "role",                    null: false
    t.string   "email",                   null: false
    t.string   "nmls_number"
    t.datetime "nmls_issued"
    t.datetime "nmls_expiration"
    t.integer  "broker_approval_form_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tpo_user_access_requests", ["broker_approval_form_id"], name: "tpo_baf_index", using: :btree

  create_table "turn_time_stats", force: :cascade do |t|
    t.string "drawing_docs", null: false
    t.string "underwriting", null: false
    t.string "conditions",   null: false
    t.string "funding",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "type",                   default: "User"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["type"], name: "index_users_on_type", using: :btree

end
