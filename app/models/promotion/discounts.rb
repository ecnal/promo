module Promotion::Discounts
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
end
