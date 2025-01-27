require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe '#calculate_savings' do
    let(:cart) { create(:cart) }

    context 'with buy x get y discount thru promotion item' do
      let(:promotion) { create(:promotion, promotion_type: 'buy_x_get_y', min_quantity: 0, discount_quantity: 5, value: 15.0) }
      let(:item) { create(:item, price: 20.0) }

      before do
        promotion.items << item
        cart.add_item(item, 5)
      end

      it 'calculates correct savings' do
        expect(promotion.calculate_savings(cart)).to eq(15.0)
      end
    end

    context 'with buy x get y discount thru promotion category' do
      let(:category) { create(:category) }
      let(:promotion) { create(:promotion, promotion_type: 'buy_x_get_y', min_quantity: 0, discount_quantity: 5, value: 15.0) }
      let(:item) { create(:item, price: 20.0) }

      before do
        item.categories << category
        promotion.categories << category
        cart.add_item(item, 5)
      end

      it 'calculates correct savings' do
        expect(promotion.calculate_savings(cart)).to eq(15.0)
      end
    end
  end
end
