# frozen_string_literal: true

module Rules
  class BulkDiscount
    ELIGIBLE_ITEM_CODE = 001
    PRICE_REDUCTION = 0.75

    def initialize(basket)
      @basket = basket
    end

    def eligible?
      !!eligible_item && count_eligible_item >= 2
    end

    def discount
      return 0 unless eligible?

      count_eligible_item * PRICE_REDUCTION
    end

    private

    def eligible_item
      @basket.find { |item| item.code == ELIGIBLE_ITEM_CODE }
    end

    def count_eligible_item
      @basket.count { |item| item.code == ELIGIBLE_ITEM_CODE }
    end
  end
end
