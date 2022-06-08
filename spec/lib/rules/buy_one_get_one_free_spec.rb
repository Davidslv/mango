require 'item_storage'
require './lib/rules/buy_one_get_one_free'

module Rules
  RSpec.describe BuyOneGetOneFree do
    let(:item) { ItemStorage.find(004) }
    let(:minimum_quantity) { 2 }

    subject do
      described_class.new(
        item: item,
        minimum_quantity: minimum_quantity
      )
    end

    describe '#discount' do
      let(:basket) { [item, item] }

      it 'returns the value to be discounted' do
        expect(
          subject.discount(basket, nil)
        ).to eq(11.23)
      end

      context 'when basket has multiples of minimum quantity' do
        let(:basket) { super().append(item, item) }

        it 'returns the value to be discounted' do
          expect(
            subject.discount(basket, nil)
          ).to eq(22.46)
        end
      end

      context 'when there are 3 of the eligible item' do
        let(:basket) { super().append(item) }

        it 'returns the value to be discounted' do
          expect(
            subject.discount(basket, nil)
          ).to eq(11.23)
        end
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
