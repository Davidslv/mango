# frozen_string_literal: true

require 'item_storage'

class Checkout
  def initialize(rules = [])
    @rules = rules
    @basket = []
    @items = ItemStorage.new
  end

  def scan(item_code)
    item = @items.find(item_code)
    return false unless item

    @basket << item
    true
  end

  def total
    total = @basket.sum(&:price)

    @rules.each do |rule|
      rule = rule.new(@basket)

      total -= rule.discount
    end

    total.round(2)
  end
end
