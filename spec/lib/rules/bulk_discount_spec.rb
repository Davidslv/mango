require 'item_storage'
require './lib/rules/bulk_discount'

module Rules
  RSpec.describe BulkDiscount do
    let(:item) { ItemStorage.new.find(001) }

    let(:conditions) do
      {
        item: item,
        minimum_quantity: 2,
        price_reduction: 0.75
      }
    end

    subject { described_class.new(conditions) }

    describe '#discount' do
      let(:basket) { [item, item] }

      it 'returns the value of the discount to be reduced from the total' do
        expect(
          subject.discount(basket: basket)
        ).to eq(1.50)
      end

      context 'when only one eligible item' do
        let(:basket) { [item] }

        it 'returns zero' do
          expect(subject.discount(basket: basket)).to eq(0)
        end
      end

      context 'when basket is empty' do
        let(:basket) { [] }

        it 'returns zero' do
          expect(subject.discount(basket: basket)).to eq(0)
        end
      end
    end
  end
end
