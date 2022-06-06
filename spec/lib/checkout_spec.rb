require './lib/checkout'

RSpec.describe Checkout do

  it { expect(described_class.class).to be(Class) }

  describe '#new' do
    it { expect{ described_class.new }.to_not raise_error(ArgumentError) }
  end

  describe '#scan' do
    subject(:checkout) { described_class.new }

    context 'when item exists' do
      it 'returns true' do
        expect(checkout.scan(001)).to be(true)
      end
    end

    context 'when item does not exist' do
      it 'returns false' do
        expect(checkout.scan(000)).to be(false)
      end
    end
  end

  describe '#total' do
    context 'when there are no pricing rules' do
      it 'returns the total without discounts' do
        checkout = described_class.new
        checkout.scan(001)
        checkout.scan(002)
        checkout.scan(003)

        expect(checkout.total).to eq(74.20)
      end
    end

    context 'when there are princing rules' do
      let(:subject) { described_class.new(rules) }
      let(:bulk_discount_rule) do
        Rules::BulkDiscount.new(
          item: ItemStorage.find(001),
          minimum_quantity: 2,
          price_reduction: 0.75
        )
      end

      let(:discount_rule) do
        Rules::Discount.new(
          percentage: 0.10,
          minimum_spent: 60
        )
      end

      let(:rules) do
        [ bulk_discount_rule, discount_rule ]
      end

      it 'calculates the total with the 10% discount' do
        subject.scan(001)
        subject.scan(002)
        subject.scan(003)

        expect(subject.total).to eq(66.78)
      end

      it 'calculates the total with bulk discount' do
        subject.scan(001)
        subject.scan(003)
        subject.scan(001)

        expect(subject.total).to eq(36.95)
      end

      it 'calculates the total with bulk discount and 10% discount' do
        subject.scan(001)
        subject.scan(002)
        subject.scan(001)
        subject.scan(003)

        expect(subject.total).to eq(73.76)
      end
    end
  end
end
