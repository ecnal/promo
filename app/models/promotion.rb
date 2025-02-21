class Promotion < ApplicationRecord
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

  def calculate_savings(cart)
    case promotion_type
    when "flat_fee"
      calculate_flat_fee_savings(cart)
    when "percentage"
      calculate_percentage_savings(cart)
    when "buy_x_get_y"
      calculate_buy_x_get_y_savings(cart)
    when "weight_threshold"
      calculate_weight_threshold_savings(cart)
    end
  end

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

  def calculate_item_discount(cart_item)
      original_price = cart_item.original_price
      case promotion_type
      when "flat_fee"
        [ original_price - value, 0 ].max
      when "percentage"
        original_price * (1 - value / 100.0)
      when "buy_x_get_y"
        calculate_buy_x_get_y_price(cart_item, original_price)
      when "weight_threshold"
        calculate_weight_threshold_price(cart_item, original_price)
      else
        original_price
      end
    end

    def calculate_buy_x_get_y_price(cart_item, original_price)
      return original_price if cart_item.quantity < min_quantity
      groups = cart_item.quantity / (min_quantity)
      discounted_quantity = groups * discount_quantity
      original_price * (cart_item.quantity - discounted_quantity +
        (discounted_quantity * (1 - value / 100.0)))
    end

    def calculate_weight_threshold_price(cart_item, original_price)
      return original_price unless cart_item.item.sale_type == "weight"
      return original_price if cart_item.quantity < weight_threshold
      original_price * (1 - value / 100.0)
    end

  def buy_x_get_y?
    promotion_type == "buy_x_get_y"
  end

  def weight_threshold?
    promotion_type == "weight_threshold"
  end

  def calculate_flat_fee_savings(cart)
    applicable_items(cart).sum { |item| value }
  end

  def calculate_percentage_savings(cart)
    applicable_items(cart).sum do |item|
      cart_item = cart.cart_items.find_by(item: item)
      cart_item.original_price * (value / 100.0)
    end
  end

  def calculate_buy_x_get_y_savings(cart)
    applicable_items(cart).sum do |item|
      cart_item = cart.cart_items.find_by(item: item)
      groups = cart_item.quantity / (min_quantity)
      discount_items = groups * discount_quantity
      discount_items * item.price * (value / 100.0)
    end
  end

  def calculate_weight_threshold_savings(cart)
    applicable_items(cart).sum do |item|
      next 0 unless item.sale_type == "weight"
      cart_item = cart.cart_items.find_by(item: item)
      if cart_item.quantity >= weight_threshold
        cart_item.original_price * (value / 100.0)
      else
        0
      end
    end
  end
end
