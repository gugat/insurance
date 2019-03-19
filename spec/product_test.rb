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

    context 'when the product is other than Mega Coverage' do
      subject { Product.new('Low Coverage', 5, 7) }
      it 'decreases the day to sell by 1' do
        expect(subject.update_price.sellIn).to eq(4)
      end
    end

    context 'when the product is Low Coverage' do
      it 'decreases price by 1 when has many days to sell' do
        product = Product.new('Low Coverage', 5, 7)
        expect(product.update_price.price).to eq(6)
      end
      it 'does not decrease price when has less than 0 days to sell' do
        product = Product.new('Low Coverage', -1, 0)
        expect(product.update_price.price).to eq(0)
      end
      context 'when has 0 days to sell' do
        it 'decreases price by 2 when price can stay positive' do
          product = Product.new('Low Coverage', 0, 2)
          expect(product.update_price.price).to eq(0)
          product = Product.new('Low Coverage', 0, 3)
          expect(product.update_price.price).to eq(1)
        end
        it 'sets price at 0 when it can not stay positive' do
          product = Product.new('Low Coverage', 0, 1)
          expect(product.update_price.price).to eq(0)
        end
      end
    end
  end
end