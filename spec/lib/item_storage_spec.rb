require './lib/item_storage'

RSpec.describe ItemStorage do
  describe '.find' do
    context 'when item exists in storage' do
      it 'returns the item' do
        item = described_class.find(001)

        expect(item.code).to eq(001)
      end
    end

    context 'when item does not exist in storage' do
      it 'returns nil' do
        item = described_class.find(0)

        expect(item).to be_nil
      end
    end
  end
end
