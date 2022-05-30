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
end
