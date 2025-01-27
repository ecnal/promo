class PromotionCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :promotion_categories do |t|
      t.references :promotion, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end

    add_index :promotion_categories, [ :promotion_id, :category_id ], unique: true
  end
end
