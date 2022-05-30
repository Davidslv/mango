require 'item'
require './lib/rules/discount'

module Rules
  RSpec.describe Discount do
    subject { described_class.new(basket) }
    let(:basket) { [] }

    describe '#eligible?' do
      context 'when basket is empty' do
        it 'returns false' do
          expect(subject.eligible?).to be(false)
        end
      end

      context 'when basket has a total of £60' do
        let(:basket) do
          [Item.new(code: 10, name: 'coffee', price: 60)]
        end

        it 'returns false' do
          expect(subject.eligible?).to be(false)
        end
      end

      context 'when basket has a total of £60.01' do
        let(:basket) do
          [Item.new(code: 10, name: 'coffee', price: 60.01)]
        end

        it 'returns true' do
          expect(subject.eligible?).to be(true)
        end
      end
    end

    describe '#discount' do
      let(:basket) do
        [Item.new(code: 10, name: 'coffee', price: 60.01)]
      end

      it 'the value of the discount to be reduced from the total' do
        expect(subject.discount).to eq(6.0)
      end
    end
  end
end
