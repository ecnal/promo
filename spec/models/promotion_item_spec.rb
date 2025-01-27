require 'rails_helper'

RSpec.describe PromotionItem, type: :model do
  describe 'associations' do
    it { should belong_to(:promotion) }
    it { should belong_to(:item) }
  end
end
