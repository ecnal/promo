FactoryBot.define do
  factory :promotion do
    sequence(:name) { |n| "Promotion #{n}" }
    start_time { Time.current }
    end_time { 1.week.from_now }

    # Discount types
    trait :flat_fee do
      promotion_type { :flat_fee }
    end

    trait :percentage do
      promotion_type { :percentage }
    end

    trait :buy_x_get_y do
      promotion_type { :buy_x_get_y }
      buy_quantity { rand(1..3) }
      get_quantity { rand(1..2) }
    end

    trait :weight_threshold do
      promotion_type { :weight_threshold }
      minimum_weight { rand(50..200) }
    end

    # Promotion scope
    trait :for_item do
    end

    trait :for_category do
    end

    # Default to a percentage promotion for an item if no specific trait is used
    initialize_with do
      new(
        name: name,
        promotion_type: :percentage,
        start_time: start_time,
        end_time: end_time,
      )
    end
  end
end
