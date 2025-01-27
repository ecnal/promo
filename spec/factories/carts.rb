FactoryBot.define do
  factory :cart do
    # transient do
    #   item_count { 3 }
    # end

    # after(:create) do |cart, evaluator|
    #   create_list(:cart_item, evaluator.item_count, cart: cart)
    # end
  end

  factory :cart_item do
    # cart
    # item
    # quantity { rand(1..5) }
  end
end
