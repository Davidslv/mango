# frozen_string_literal: true

module Rules
  class Discount
    TEN_PERCENT = 0.10
    MINIMUM_SPENT = 60

    def initialize(basket, total)
      @basket = basket
      @total = total
    end

    def eligible?
      @total > MINIMUM_SPENT
    end

    def discount
      return 0 unless eligible?

      (@total * TEN_PERCENT)
    end
  end
end
