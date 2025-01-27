class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :applied_promotion, class_name: "Promotion", optional: true

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def original_price
    item.price * quantity
  end
end
