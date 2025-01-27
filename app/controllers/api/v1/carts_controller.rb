module Api
  module V1
    class CartsController < ApplicationController
      def show
        cart = Cart.find(params[:cart_id])
        render json: ::V1::CartSerializer.new(cart).serializable_hash
      end

      def add_item
        result = current_cart.add_item(item, quantity_param)
        if result
          render json: ::V1::CartSerializer.new(current_cart).serializable_hash
        else
          render json: { errors: current_cart.errors }, status: :unprocessable_entity
        end
      end

      def remove_item
        result = current_cart.remove_item(item, quantity_param)
        if result
          render json: ::V1::CartSerializer.new(current_cart).serializable_hash
        else
          render json: { errors: current_cart.errors }, status: :unprocessable_entity
        end
      end

      private

      def current_cart
        @current_cart ||= Cart.find_or_create_by(id: params[:cart_id])
      end

      def item
        @item ||= Item.find(params[:item_id])
      end

      def quantity_param
        params[:quantity].to_f
      end
    end
  end
end
