# frozen_string_literal: true

module Rules
  class BulkDiscount
    def initialize(item:, minimum_quantity:, price_reduction:)
      @item = item
      @minimum_quantity = minimum_quantity
      @price_reduction = price_reduction
    end

    def discount(basket, _total)
      return 0 unless eligible?(basket)

      count_eligible_item(basket) * @price_reduction
    end

    private

    def eligible?(basket)
      eligible_item(basket) && count_eligible_item(basket) >= @minimum_quantity
    end

    def eligible_item(basket)
      basket.include?(@item)
    end

    def count_eligible_item(basket)
      basket.count(@item)
    end
  end
end
