require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:promotion_type) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:value) }

    context 'when promotion_type is buy_x_get_y' do
      subject { build(:promotion, promotion_type: 'buy_x_get_y') }

      it { should validate_presence_of(:min_quantity) }
      it { should validate_presence_of(:discount_quantity) }
    end

    context 'when promotion_type is weight_threshold' do
      subject { build(:promotion, promotion_type: 'weight_threshold') }

      it { should validate_presence_of(:weight_threshold) }
    end
  end
end
