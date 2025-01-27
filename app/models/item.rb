class Item < ApplicationRecord
  belongs_to :brand, optional: true
  has_many :category_items
  has_many :categories, through: :category_items
  has_many :cart_items
  has_many :carts, through: :cart_items
  has_many :promotion_items
  has_many :promotions, through: :promotion_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_type, presence: true, inclusion: { in: [ "weight", "quantity" ] }

  # Applies to sale_type == 'weight'
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
