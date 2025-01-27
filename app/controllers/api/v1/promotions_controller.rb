module Api
  module V1
    class PromotionsController < ApplicationController
      def index
        promotions = Promotion.includes(:items, :categories)
        render json: ::V1::PromotionSerializer.new(promotions).serializable_hash
      end

      def create
        promotion = Promotion.new(promotion_params)
        if promotion.save
          render json: ::V1::PromotionSerializer.new(promotion).serializable_hash,
                 status: :created
        else
          render json: { errors: promotion.errors }, status: :unprocessable_entity
        end
      end

      private

      def promotion_params
        params.require(:promotion).permit(
          :name, :promotion_type, :value, :start_time, :end_time,
          :min_quantity, :discount_quantity, :weight_threshold,
          item_ids: [], category_ids: []
        )
      end
    end
  end
end
