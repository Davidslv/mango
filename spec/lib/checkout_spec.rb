require './lib/checkout'

RSpec.describe Checkout do

  it { expect(described_class.class).to be(Class) }

  describe '#new' do
    it { expect{ described_class.new }.to_not raise_error(ArgumentError) }
  end
end
