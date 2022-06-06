# frozen_string_literal: true

module Rules
  class BulkDiscount
    def initialize(item:, minimum_quantity:, price_reduction:)
      @item = item
      @minimum_quantity = minimum_quantity
      @price_reduction = price_reduction
    end

    def discount(basket:, total: nil)
      return 0 unless eligible?(basket)

      count_eligible_item(basket) * @price_reduction
    end

    private

    def eligible?(basket)
      !!eligible_item(basket) && count_eligible_item(basket) >= 2
    end

    def eligible_item(basket)
      basket.find { |item| item.code == @item.code }
    end

    def count_eligible_item(basket)
      basket.count { |item| item.code == @item.code }
    end
  end
end
