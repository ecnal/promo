require 'rails_helper'

RSpec.describe 'Api::V1::Carts', type: :request do
  let(:item) { create(:item) }

  describe 'GET /api/v1/cart' do
    before { @cart = Cart.create.add_item(item, 2) }

    it 'returns the cart' do
      get api_v1_cart_path, params: { cart_id: @cart.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/cart/add_item' do
    let(:valid_params) {
      {
        item_id: item.id,
        quantity: 2
      }
    }

    it 'adds item to cart' do
      expect {
        post add_item_api_v1_cart_path, params: valid_params
      }.to change { CartItem.count }.by(1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/cart/remove_item' do
    before { @cart = Cart.create.add_item(item, 2) }

    it 'removes item from cart' do
      expect {
        post remove_item_api_v1_cart_path, params: { cart_id: @cart.id, item_id: item.id, quantity: 2 }
      }.to change { CartItem.count }.by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
