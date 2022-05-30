require './lib/item'

RSpec.describe Item do

  let(:valid_attributes) do
    {
      code: 001,
      name: 'Lavender',
      price: 9.25
    }
  end

  describe '#new' do
    it { expect { described_class.new }.to raise_error(ArgumentError) }

    context 'with valid attributes' do
      it 'creates an instance of Item with given attributes' do
        item = Item.new(
          code: valid_attributes[:code],
          name: valid_attributes[:name],
          price: valid_attributes[:price]
        )

        expect(item.code).to eq(001)
        expect(item.name).to eq('Lavender')
        expect(item.price).to eq(9.25)
      end
    end
  end
end
