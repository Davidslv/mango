require 'item'
require './lib/rules/bulk_discount'

module Rules
  RSpec.describe BulkDiscount do
    subject { described_class.new(basket) }
    let(:basket) { [] }

    describe '#eligible?' do
      context 'when basket is empty' do
        it 'returns false' do
          expect(subject.eligible?).to be(false)
        end
      end

      context 'when basket has two eligble items' do
        let(:basket) {
          [
            Item.new(code: 001, name: 'lavender', price: 9.25),
            Item.new(code: 001, name: 'lavender', price: 9.25)
          ]
        }

        it 'returns true' do
          expect(subject.eligible?).to be(true)
        end
      end
    end

    describe '#discount' do
      let(:basket) {
        [
          Item.new(code: 001, name: 'lavender', price: 9.25),
          Item.new(code: 001, name: 'lavender', price: 9.25)
        ]
      }

      it 'returns the value of the discount to be reduced from the total' do
        expect(subject.discount).to eq(1.50)
      end

      context 'when only one eligible item' do
        let(:basket) { [ Item.new(code: 001, name: 'lavender', price: 9.25) ] }

        it 'returns zero' do
          expect(subject.discount).to eq(0)
        end
      end
    end
  end
end
