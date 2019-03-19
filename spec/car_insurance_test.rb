require_relative '../src/car_insurance'
require_relative '../src/product'
require_relative 'spec_helper'

RSpec.describe CarInsurance, type: :model do
  let(:products) do
    [Product.new('Low Coverage', 5, 7),
     Product.new('Medium Coverage', 10, 20)]
  end

  context 'validations' do
    subject { CarInsurance.new(products: products) }
    it { should validate_presence_of(:products) }
  end

  context 'public methods' do
    describe '#updatePrice' do
      subject { CarInsurance.new(products) }
      it 'returns the same number of products it receives' do
        expect(subject.updatePrice.size).to eq(2)
      end

      it 'calls update_price in each product' do
        subject.products.each do |product|
          expect(product).to receive(:update_price)
        end
        subject.updatePrice
      end
    end
  end
end
