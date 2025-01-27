module V1
  class CartItemSerializer
    include JSONAPI::Serializer

    attributes :cart_id, :item_id, :created_at, :updated_at,
               :quantity, :discounted_price, :applied_promotion_id

    attributes :original_price do |ci|
      ci.original_price
    end
  end
end
