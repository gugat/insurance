require_relative '../src/product'
require_relative 'spec_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { Product.new('Mega Coverage', -1, 80) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:sellIn) }
    it { should validate_presence_of(:price) }
  end

  describe 'update_price' do
    context 'when the product is Mega Coverage' do
      subject { Product.new('Mega Coverage', -1, 80).update_price }
      it 'never decreases price' do
        expect(subject.price).to eq(80)
      end
      it 'never decreases days to sell' do
        expect(subject.sellIn).to eq(-1)
      end
    end
  end
end