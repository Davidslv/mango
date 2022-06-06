require 'item_storage'
require './lib/rules/discount'

module Rules
  RSpec.describe Discount do
    subject { described_class.new(conditions) }

    let(:conditions) do
      {
        percentage: 0.10,
        minimum_spent: 60
      }
    end

    let(:basket) { [] }
    let(:total) { basket.sum(&:price) }

    describe '#discount' do
      context 'when total is less than minimum spent' do
        it 'returns zero' do
          expect(subject.discount(total: total)).to eq(0)
        end
      end

      context 'when basket is not empty' do
        let(:basket) do
          [ItemStorage.new.find(001)]
        end

        context 'and basket is not minimum spent' do
          it 'returns zero' do
            expect(subject.discount(total: total)).to eq(0)
          end
        end

        context 'and basket is over minimum spent' do
          before do
            basket << ItemStorage.new.find(002)
            basket << ItemStorage.new.find(002)
          end

          it 'returns the value of the discount to be reduced from the total' do
            expect(subject.discount(total: total)).to eq(9.925)
          end
        end
      end
    end
  end
end
