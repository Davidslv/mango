# frozen_string_literal: true

require_relative 'item'

class ItemStorage
  class << self
    def find(item_code)
      storage.find { |item| item.code == item_code }
    end

    private

    def storage
      @storage ||= [
        Item.new(code: 001, name: 'Lavender heart ', price: 9.25),
        Item.new(code: 002, name: 'Personalised cufflinks', price: 45.00),
        Item.new(code: 003, name: 'Kids T-shirt', price: 19.95),
        Item.new(code: 004, name: 'Coffee', price: 11.23)
      ]
    end
  end
end
