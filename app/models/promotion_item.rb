class PromotionItem < ApplicationRecord
  belongs_to :promotion
  belongs_to :item
end
