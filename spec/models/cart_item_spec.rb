require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:item) }
    it { should belong_to(:applied_promotion).optional }
  end
end
