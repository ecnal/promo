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

ActiveRecord::Schema[8.0].define(version: 2025_02_19_160659) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "analytics", force: :cascade do |t|
    t.string "source"
    t.integer "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity", precision: 10, scale: 2, default: "1.0", null: false
    t.decimal "discounted_price", precision: 10, scale: 2
    t.bigint "applied_promotion_id"
    t.index ["applied_promotion_id"], name: "index_cart_items_on_applied_promotion_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "category_items", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "item_id"], name: "index_category_items_on_category_id_and_item_id", unique: true
    t.index ["category_id"], name: "index_category_items_on_category_id"
    t.index ["item_id"], name: "index_category_items_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.string "sale_type", null: false
    t.decimal "quantity", precision: 10, scale: 2, null: false
    t.bigint "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_items_on_brand_id"
    t.index ["sale_type"], name: "index_items_on_sale_type"
  end

  create_table "promotion_categories", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_promotion_categories_on_category_id"
    t.index ["promotion_id", "category_id"], name: "index_promotion_categories_on_promotion_id_and_category_id", unique: true
    t.index ["promotion_id"], name: "index_promotion_categories_on_promotion_id"
  end

  create_table "promotion_items", force: :cascade do |t|
    t.bigint "promotion_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_promotion_items_on_item_id"
    t.index ["promotion_id", "item_id"], name: "index_promotion_items_on_promotion_id_and_item_id", unique: true
    t.index ["promotion_id"], name: "index_promotion_items_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "name", null: false
    t.string "promotion_type", null: false
    t.decimal "value", precision: 10, scale: 2, null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.integer "min_quantity"
    t.integer "discount_quantity"
    t.decimal "weight_threshold", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_time"], name: "index_promotions_on_end_time"
    t.index ["promotion_type"], name: "index_promotions_on_promotion_type"
    t.index ["start_time"], name: "index_promotions_on_start_time"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "cart_items", "promotions", column: "applied_promotion_id"
  add_foreign_key "category_items", "categories"
  add_foreign_key "category_items", "items"
  add_foreign_key "items", "brands"
  add_foreign_key "promotion_categories", "categories"
  add_foreign_key "promotion_categories", "promotions"
  add_foreign_key "promotion_items", "items"
  add_foreign_key "promotion_items", "promotions"
end
