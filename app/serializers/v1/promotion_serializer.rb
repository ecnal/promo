module V1
  class PromotionSerializer
    include JSONAPI::Serializer

    attributes :promotion_type, :value, :start_time, :end_time,
               :min_quantity, :discount_quantity, :weight_threshold

    has_many :items
    has_many :categories
  end
end
