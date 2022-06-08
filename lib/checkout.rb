# frozen_string_literal: true

require_relative 'rules/bulk_discount'
require_relative 'rules/buy_one_get_one_free'
require_relative 'rules/discount'
require_relative 'item_storage'

class Checkout
  def initialize(rules = [])
    @rules = reorder_rules(rules)
    @basket = []
  end

  def scan(item_code)
    item = ItemStorage.find(item_code)
    return false unless item

    @basket << item
    true
  end

  def total
    total = @basket.sum(&:price)

    @rules.each do |rule|
      total -= rule.discount(@basket, total)
    end

    total.round(2)
  end

  private

  # Make sure that Rules::Discount is applied at the very end
  # This gives opportunity for all other discounts to be applied
  # Which means that a overall percentage discount is applied at the end.
  def reorder_rules(rules)
    return [] if rules.empty?
    return rules unless rules.map(&:class).include?(Rules::Discount)

    discount_rule_index = rules.map(&:class).index(Rules::Discount)
    discount_rule = rules.delete_at(discount_rule_index)
    rules.append(discount_rule)
  end
end
