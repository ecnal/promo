class Promotion < ApplicationRecord
  include Promotion::Savings
  include Promotion::Discounts

  has_many :promotion_items
  has_many :items, through: :promotion_items
  has_many :promotion_categories
  has_many :categories, through: :promotion_categories

  validates :promotion_type, presence: true, inclusion: {
    in: [ "flat_fee", "percentage", "buy_x_get_y", "weight_threshold" ]
  }
  validates :start_time, presence: true
  validates :value, presence: true
  validates :min_quantity, presence: true, if: :buy_x_get_y?
  validates :discount_quantity, presence: true, if: :buy_x_get_y?
  validates :weight_threshold, presence: true, if: :weight_threshold?

  scope :current, -> {
    where("start_time <= ? AND (end_time IS NULL OR end_time > ?)",
          Time.current, Time.current)
  }

  def applicable_items(cart)
    items_in_cart = cart.cart_items.includes(:item).map(&:item)

    if promotion_categories.any?
      category_items = categories.flat_map(&:items)
      items_in_cart & category_items
    else
      items_in_cart & items
    end
  end

  def apply_to(cart, cart_items)
      cart_items.each do |item|
        cart_item = cart.cart_items.find_by(item: item)
        next unless cart_item

        discounted_price = calculate_item_discount(cart_item)
        cart_item.update(
          applied_promotion_id: id,
          discounted_price: discounted_price
        )
      end
    end

  private

  def buy_x_get_y?
    promotion_type == "buy_x_get_y"
  end

  def weight_threshold?
    promotion_type == "weight_threshold"
  end
end
