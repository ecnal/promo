module V1
  class CartSerializer
    include JSONAPI::Serializer

    attributes :total_price do |cart|
      cart.cart_items.sum { |ci| ci.discounted_price || ci.original_price }
    end

    attributes :total_savings do |cart|
      cart.cart_items.sum { |ci| ci.original_price - (ci.discounted_price || ci.original_price) }
    end

    attributes :cart_items do |cart|
      V1::CartItemSerializer.new(cart.cart_items).serializable_hash
    end
  end
end
