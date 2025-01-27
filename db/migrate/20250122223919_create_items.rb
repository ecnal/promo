class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :sale_type, null: false  # 'weight' or 'quantity'
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.references :brand, foreign_key: true
      t.timestamps
    end

    add_index :items, :sale_type
  end
end
