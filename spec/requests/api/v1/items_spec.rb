require 'rails_helper'

RSpec.describe 'Api::V1::Items', type: :request do
  describe 'GET /api/v1/items' do
    let!(:items) { create_list(:item, 3) }

    it 'returns all items' do
      get api_v1_items_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data'].size).to eq(3)
    end
  end

  describe 'GET /api/v1/items/:id' do
    let!(:item) { create(:item) }

    it 'returns single item' do
      get api_v1_item_path(item.id)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['data']['id']).to eq(item.id.to_s)
    end
  end

  describe 'POST /api/v1/items' do
    let(:valid_attributes) {
      {
        item: {
          name: 'New Item',
          price: 99.99,
          sale_type: 'quantity',
          quantity: 100
        }
      }
    }

    context 'with valid parameters' do
      it 'creates a new item' do
        expect {
          post api_v1_items_path, params: valid_attributes
        }.to change(Item, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post api_v1_items_path, params: { item: { name: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
