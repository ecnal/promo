require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:cart) { create(:cart) }

  context 'Only the single best possible discount given multiple valid promotions' do
    let(:category) { create(:category) }
    let(:promotion1) { create(:promotion, promotion_type: 'flat_fee', value: 5.0) }
    let(:promotion2) { create(:promotion, promotion_type: 'flat_fee', value: 10.0) }
    let(:item) { create(:item, price: 20.0) }

    before do
      item.categories << category
      promotion1.items << item
      promotion2.categories << category
      cart.add_item(item, 1)
    end

    it 'calculates correct savings' do
      cart_item = cart.cart_items.find_by(item_id: item.id)
      expect(cart_item.discounted_price).to eq(10.0)
    end
  end
end
