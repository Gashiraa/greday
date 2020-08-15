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

ActiveRecord::Schema.define(version: 2020_08_15_070056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "postcode"
    t.string "locality"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_name"
    t.boolean "use_services", default: true
    t.boolean "use_wares", default: true
    t.boolean "oto_invoice", default: true
    t.boolean "use_manual_extras", default: true
    t.boolean "use_articles", default: true
    t.boolean "use_machines", default: true
    t.boolean "use_credit_notes", default: true
    t.boolean "use_manual_invoice_number", default: true
    t.string "vat"
    t.string "mode"
    t.string "account"
    t.string "bic"
    t.string "prefix"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "mail"
    t.string "tva_record"
    t.string "street"
    t.string "number"
    t.integer "cp"
    t.string "locality"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.float "customer_rate"
  end

  create_table "expense_accounts", force: :cascade do |t|
    t.boolean "reverse_invoice"
    t.bigint "invoice_id"
    t.text "description"
    t.float "total_gross"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.date "date"
    t.index ["customer_id"], name: "index_expense_accounts_on_customer_id"
    t.index ["invoice_id"], name: "index_expense_accounts_on_invoice_id"
  end

  create_table "extras", force: :cascade do |t|
    t.string "name"
    t.string "unit"
    t.string "unit_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "tva_rate"
    t.string "category"
    t.boolean "delete_flag"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "payment_id"
    t.date "date"
    t.integer "status"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "customer_id"
    t.float "total_gross"
    t.integer "display_number"
    t.index ["customer_id"], name: "index_invoices_on_customer_id"
    t.index ["payment_id"], name: "index_invoices_on_payment_id"
  end

  create_table "machine_histories", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.bigint "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_machine_histories_on_machine_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "model"
    t.string "brand"
    t.string "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.bigint "customer_id"
    t.text "comment"
    t.string "serial"
    t.text "oils_text"
    t.boolean "isKm"
    t.index ["customer_id"], name: "index_machines_on_customer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.date "date"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.bigint "customer_id"
    t.float "total"
    t.index ["customer_id"], name: "index_payments_on_customer_id"
  end

  create_table "project_extra_lines", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "extra_id"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_gross"
    t.float "total"
    t.boolean "is_manual"
    t.string "manual_name"
    t.float "manual_price"
    t.string "unit"
    t.float "tva_rate"
    t.integer "position"
    t.index ["extra_id"], name: "index_project_extra_lines_on_extra_id"
    t.index ["project_id"], name: "index_project_extra_lines_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "invoice_id"
    t.bigint "customer_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.float "total_gross"
    t.float "total"
    t.date "date"
    t.string "po"
    t.string "applicant"
    t.boolean "no_vat"
    t.text "comment"
    t.bigint "machine_id"
    t.boolean "services_recap"
    t.text "services_recap_text"
    t.text "displacement_recap"
    t.integer "machine_history"
    t.index ["customer_id"], name: "index_projects_on_customer_id"
    t.index ["invoice_id"], name: "index_projects_on_invoice_id"
    t.index ["machine_id"], name: "index_projects_on_machine_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "customer_id"
    t.string "name"
    t.string "comment"
    t.float "hourly_rate"
    t.float "coefficient"
    t.date "date"
    t.time "duration"
    t.integer "status"
    t.float "tva_rate"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_gross"
    t.time "start_time"
    t.time "end_time"
    t.string "provider"
    t.boolean "show_desc_invoice"
    t.boolean "show_desc_quote"
    t.boolean "is_displacement"
    t.integer "position"
    t.index ["project_id"], name: "index_services_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isAdmin"
    t.string "locale"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wares", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "customer_id"
    t.string "ware_name"
    t.string "comment"
    t.float "quantity"
    t.float "provider_discount"
    t.float "margin"
    t.float "provider_price"
    t.integer "status"
    t.float "tva_rate"
    t.float "total_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider_name"
    t.string "provider_invoice"
    t.float "bought_price"
    t.float "provider_gross"
    t.float "total_gross"
    t.float "sell_price"
    t.boolean "show_desc_invoice"
    t.boolean "machine_specific"
    t.boolean "is_maintenance"
    t.bigint "machine_id"
    t.boolean "show_desc_quot"
    t.integer "position"
    t.index ["customer_id"], name: "index_wares_on_customer_id"
    t.index ["machine_id"], name: "index_wares_on_machine_id"
    t.index ["project_id"], name: "index_wares_on_project_id"
  end

  add_foreign_key "expense_accounts", "customers"
  add_foreign_key "expense_accounts", "invoices"
  add_foreign_key "invoices", "payments"
  add_foreign_key "machine_histories", "machines"
  add_foreign_key "machines", "customers"
  add_foreign_key "payments", "customers"
  add_foreign_key "project_extra_lines", "extras"
  add_foreign_key "project_extra_lines", "projects"
  add_foreign_key "projects", "customers"
  add_foreign_key "projects", "invoices"
  add_foreign_key "projects", "machines"
  add_foreign_key "services", "customers"
  add_foreign_key "services", "projects"
  add_foreign_key "users", "companies"
  add_foreign_key "wares", "customers"
  add_foreign_key "wares", "machines"
  add_foreign_key "wares", "projects"
end
