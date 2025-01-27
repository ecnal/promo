FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }

    # Selling unit type
    trait :by_weight do
      sale_type { :weight }
      weight { rand(50..500) }
      weight_unit { 'grams' }
    end

    trait :by_quantity do
      sale_type { :quantity }
      quantity { rand(1..100) }
    end

    # Price and base details
    price { rand(10.0..500.0).round(2) }
    brand
    # category

    # Default to selling by quantity if no specific trait is used
    initialize_with do
      new(
        name: name,
        price: price,
        sale_type: :quantity,
        quantity: rand(1..100),
        brand: brand,
        # category: category
      )
    end
  end
end
