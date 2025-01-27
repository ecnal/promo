class PromotionItems < ActiveRecord::Migration[8.0]
  def change
    create_table :promotion_items do |t|
      t.references :promotion, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end

    add_index :promotion_items, [ :promotion_id, :item_id ], unique: true
  end
end
