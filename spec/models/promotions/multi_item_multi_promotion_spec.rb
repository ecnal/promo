require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:cart) { create(:cart) }

  context 'Multiple items get seperate Promotions applied' do
    let(:category) { create(:category) }
    let(:promotion1) { create(:promotion, promotion_type: 'flat_fee', value: 5.0) }
    let(:promotion2) { create(:promotion, promotion_type: 'flat_fee', value: 10.0) }
    let(:item1) { create(:item, price: 20.0) }
    let(:item2) { create(:item, price: 20.0) }

    before do
      promotion1.items << item1
      item2.categories << category
      promotion2.categories << category
      cart.add_item(item1, 1)
      cart.add_item(item2, 1)
    end

    it 'calculates correct savings' do
      cart_item1 = cart.cart_items.find_by(item_id: item1.id)
      cart_item2 = cart.cart_items.find_by(item_id: item2.id)
      expect(cart_item1.discounted_price).to eq(15.0)
      expect(cart_item2.discounted_price).to eq(10.0)
    end
  end
end
