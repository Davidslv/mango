# frozen_string_literal: true

require_relative 'rules/bulk_discount'
require_relative 'rules/discount'
require_relative 'item_storage'

class Checkout
  def initialize(rules = [])
    @rules = rules
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
      total -= rule.discount(basket: @basket, total: total)
    end

    total.round(2)
  end
end
