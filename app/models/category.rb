class Category < ApplicationRecord
  has_many :category_items
  has_many :items, through: :category_items
  has_many :promotion_categories
  has_many :promotions, through: :promotion_categories

  validates :name, presence: true, uniqueness: true
end
