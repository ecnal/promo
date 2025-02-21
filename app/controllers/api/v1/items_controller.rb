module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = Item.includes(:brand, :categories)
        render json: ::V1::ItemSerializer.new(items).serializable_hash
      end

      def show
        item = Item.find(params[:id])
        Analytic.create(source: "items/show", source_id: item.id)
        render json: ::V1::ItemSerializer.new(item).serializable_hash
      end

      def create
        item = Item.new(item_params)
        if item.save
          render json: ::V1::ItemSerializer.new(item).serializable_hash, status: :created
        else
          render json: { errors: item.errors }, status: :unprocessable_entity
        end
      end

      private

      def item_params
        params.require(:item).permit(
          :name, :price, :sale_type, :quantity, :brand_id, category_ids: []
        )
      end
    end
  end
end
