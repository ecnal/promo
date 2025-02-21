class CreateAnalytics < ActiveRecord::Migration[8.0]
  def change
    create_table :analytics do |t|
      t.string :source
      t.integer :source_id
      t.timestamps
    end
  end
end
