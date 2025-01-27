require 'rails_helper'

RSpec.describe PromotionCategory, type: :model do
  describe 'associations' do
    it { should belong_to(:promotion) }
    it { should belong_to(:category) }
  end
end
