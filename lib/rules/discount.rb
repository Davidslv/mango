# frozen_string_literal: true

module Rules
  class Discount
    def initialize(percentage:, minimum_spent:)
      @percentage = percentage
      @minimum_spent = minimum_spent
    end

    def discount(_basket, total)
      return 0 unless eligible?(total)

      (total * @percentage)
    end

    private

    def eligible?(total)
      total > @minimum_spent
    end
  end
end
