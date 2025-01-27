class Cart < ApplicationRecord
  has_many :cart_items
  has_many :items, through: :cart_items

  def add_item(item, quantity = 1)
    cart_item = cart_items.find_or_initialize_by(item: item)
    if cart_item.new_record?
      cart_item.quantity = quantity
    else
      cart_item.quantity += quantity
    end
    cart_item.save
    apply_best_promotions

    self
  end

  def remove_item(item, quantity = 1)
    cart_item = cart_items.find_by(item: item)
    return unless cart_item

    cart_item.quantity -= quantity
    cart_item.quantity.positive? ? cart_item.save : cart_item.destroy
    apply_best_promotions

    self
  end

  private

  def apply_best_promotions
    reset_promotions
    available_promotions = Promotion.current.to_a

    # Sort promotions by potential savings (highest first)
    sorted_promotions = available_promotions.sort_by { |p| -p.calculate_savings(self) }

    # Apply promotions until no more can be applied
    applied_items = Set.new
    sorted_promotions.each do |promotion|
      applicable_items = promotion.applicable_items(self) - applied_items.to_a
      next if applicable_items.empty?

      promotion.apply_to(self, applicable_items)
      applied_items.merge(applicable_items)
    end
  end

  def reset_promotions
    cart_items.update_all(applied_promotion_id: nil, discounted_price: nil)
  end
end
