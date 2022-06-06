require 'item_storage'
require './lib/rules/discount'

module Rules
  RSpec.describe Discount do
    subject do
      described_class.new(percentage: percentage, minimum_spent: minimum_spent)
    end

    let(:percentage) { 0.10 }
    let(:minimum_spent) { 60 }

    let(:basket) { [] }
    let(:total) { basket.sum(&:price) }

    describe '#discount' do
      context 'when total is less than minimum spent' do
        it 'returns zero' do
          expect(subject.discount(nil, total)).to eq(0)
        end
      end

      context 'when basket is not empty' do
        let(:basket) do
          [ItemStorage.find(001)]
        end

        context 'and basket is not minimum spent' do
          it 'returns zero' do
            expect(subject.discount(nil, total)).to eq(0)
          end
        end

        context 'and basket is over minimum spent' do
          before do
            basket << ItemStorage.find(002)
            basket << ItemStorage.find(002)
          end

          it 'returns the value of the discount to be reduced from the total' do
            expect(subject.discount(nil, total)).to eq(9.925)
          end
        end
      end
    end
  end
end
