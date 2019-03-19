require_relative '../src/product'
require_relative 'spec_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { Product.new('Mega Coverage', -1, 80) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sellIn) }
    it { should validate_presence_of(:price) }
  end

  describe '#log' do
    subject { Product.new('Mega Coverage', -1, 80)}
    it 'should print the name, the days to sell and the price' do
      expect{ subject.log }.to output(/Mega Coverage, -1, 80/).to_stdout
    end
  end

  describe '#update_price' do
    context 'when the product is other than Mega Coverage' do
      subject { Product.new('Low Coverage', 5, 7) }
      it 'decreases the day to sell by 1' do
        subject.update_price
        expect(subject.sellIn).to eq(4)
      end
    end

    context 'when the product is Mega Coverage' do
      subject { Product.new('Mega Coverage', 5, 7) }
      it 'does not decrease the day to sell by 1' do
        subject.update_price
        expect(subject.sellIn).to eq(5)
      end
    end

    context 'bla' do
      subject { Product.new('Super Sale Coverage', 5, 7) }
      it 'calls the Coverager' do
        expect(Coverager).to receive(:for)
          .with('Super Sale Coverage')
          .and_call_original
        subject.update_price
      end
    end

  end
end