require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'associations' do
    it { should belong_to(:brand).optional }
    it { should have_many(:categories).through(:category_items) }
    it { should have_many(:cart_items) }
    it { should have_many(:carts).through(:cart_items) }
    it { should have_many(:promotion_items) }
    it { should have_many(:promotions).through(:promotion_items) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:sale_type) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_inclusion_of(:sale_type).in_array([ 'weight', 'quantity' ]) }
  end
end
