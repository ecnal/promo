class UpdatesForCartItems < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :quantity, :decimal, precision: 10, scale: 2, null: false, default: 1
    add_column :cart_items, :discounted_price, :decimal, precision: 10, scale: 2, null: true
    add_reference :cart_items, :applied_promotion, foreign_key: { to_table: :promotions }, null: true
  end
end
