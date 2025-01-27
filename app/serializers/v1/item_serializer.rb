module V1
  class ItemSerializer
    include JSONAPI::Serializer

    attributes :name, :price, :sale_type, :quantity

    belongs_to :brand
    has_many :categories

    attribute :current_price do |item, params|
      cart_item = params[:cart]&.cart_items&.find_by(item: item)
      cart_item&.discounted_price || item.price
    end
  end
end
