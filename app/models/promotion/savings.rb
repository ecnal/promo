module Promotion::Savings
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

  private

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
