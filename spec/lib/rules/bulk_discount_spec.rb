require 'item_storage'
require './lib/rules/bulk_discount'

module Rules
  RSpec.describe BulkDiscount do
    let(:item) { ItemStorage.find(001) }
    let(:minimum_quantity) { 2 }
    let(:price_reduction) { 0.75 }

    subject do
      described_class.new(
        item: item,
        minimum_quantity: minimum_quantity,
        price_reduction: price_reduction
      )
    end

    describe '#discount' do
      let(:basket) { [item, item] }

      it 'returns the value of the discount to be reduced from the total' do
        expect(
          subject.discount(basket, nil)
        ).to eq(1.50)
      end

      context 'when only one eligible item' do
        let(:basket) { [item] }

        it 'returns zero' do
          expect(subject.discount(basket, nil)).to eq(0)
        end
      end

      context 'when basket is empty' do
        let(:basket) { [] }

        it 'returns zero' do
          expect(subject.discount(basket, nil)).to eq(0)
        end
      end
    end
  end
end
