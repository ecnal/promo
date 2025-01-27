require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { create(:cart) }
  let(:item) { create(:item, price: 10.0, sale_type: 'quantity') }

  describe '#add_item' do
    it 'adds new item to cart' do
      expect { cart.add_item(item, 2) }.to change { cart.cart_items.count }.by(1)
    end

    it 'increases quantity for existing item' do
      cart.add_item(item, 1)
      expect { cart.add_item(item, 2) }
        .to change { cart.cart_items.find_by(item: item).quantity }.by(2)
    end

    it 'applies best promotion automatically' do
      promotion = create(:promotion,
        promotion_type: 'percentage',
        value: 20,
        start_time: 1.day.ago
      )

      promotion.items << item

      cart.add_item(item, 1)
      cart_item = cart.cart_items.find_by(item: item)
      expect(cart_item.discounted_price).to eq(8.0) # 20% off 10.0
    end
  end

  describe '#remove_item' do
    before { cart.add_item(item, 3) }

    it 'decreases quantity of item' do
      expect { cart.remove_item(item, 1) }
        .to change { cart.cart_items.find_by(item: item).quantity }.by(-1)
    end

    it 'removes item when quantity reaches 0' do
      expect { cart.remove_item(item, 3) }
        .to change { cart.cart_items.count }.by(-1)
    end
  end
end
