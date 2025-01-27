class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.string :promotion_type, null: false
      t.decimal :value, precision: 10, scale: 2, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time
      t.integer :min_quantity
      t.integer :discount_quantity
      t.decimal :weight_threshold, precision: 10, scale: 2
      t.timestamps
    end

    add_index :promotions, :promotion_type
    add_index :promotions, :start_time
    add_index :promotions, :end_time
  end
end
