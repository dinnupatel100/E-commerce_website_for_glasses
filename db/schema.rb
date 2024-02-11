# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_09_115538) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "order_status"
    t.float "total_bill"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_products", force: :cascade do |t|
    t.integer "quantity"
    t.float "buying_price"
    t.date "order_date"
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_orders_products_on_order_id"
    t.index ["product_id"], name: "index_orders_products_on_product_id"
  end

  create_table "product_colors", force: :cascade do |t|
    t.string "color"
    t.string "images", default: [], array: true
    t.bigint "product_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_detail_id"], name: "index_product_colors_on_product_detail_id"
  end

  create_table "product_details", force: :cascade do |t|
    t.string "product_name"
    t.string "product_description"
    t.float "cost_price"
    t.float "selling_price"
    t.string "brand"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_details_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "size"
    t.integer "quantity"
    t.bigint "product_color_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_color_id"], name: "index_products_on_product_color_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.float "rating"
    t.string "review_message"
    t.bigint "user_id", null: false
    t.bigint "product_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_detail_id"], name: "index_reviews_on_product_detail_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.date "dob"
    t.integer "mobile_no"
    t.string "address"
    t.string "city"
    t.integer "postal_code"
    t.string "role", default: "customer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "orders", "users"
  add_foreign_key "orders_products", "orders"
  add_foreign_key "orders_products", "products"
  add_foreign_key "product_colors", "product_details"
  add_foreign_key "product_details", "categories"
  add_foreign_key "products", "product_colors"
  add_foreign_key "reviews", "product_details"
  add_foreign_key "reviews", "users"
end
