require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe '#calculate_savings' do
    let(:cart) { create(:cart) }

    context 'with percentage discount thru promotion item' do
      let(:promotion) { create(:promotion, promotion_type: 'percentage', value: 20) }
      let(:item) { create(:item, price: 100.0) }

      before do
        promotion.items << item
        cart.add_item(item, 1)
      end

      it 'calculates correct savings' do
        expect(promotion.calculate_savings(cart)).to eq(20.0)
      end
    end

    context 'with percentage discount thru promotion category' do
      let(:category) { create(:category) }
      let(:promotion) { create(:promotion, promotion_type: 'percentage', value: 20) }
      let(:item) { create(:item, price: 100.0) }

      before do
        item.categories << category
        promotion.categories << category
        cart.add_item(item, 1)
      end

      it 'calculates correct savings' do
        expect(promotion.calculate_savings(cart)).to eq(20.0)
      end
    end
  end
end
