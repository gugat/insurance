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

    context 'when the product is Super Sale' do
      it 'decreases price by 2 when has many days to sell' do
        product = Product.new('Super Sale', 5, 7)
        expect(product.update_price.price).to eq(5)
      end
      it 'does not decrease price when has less than 0 days to sell' do
        product = Product.new('Super Sale', -1, 0)
        expect(product.update_price.price).to eq(0)
      end
      context 'when has 0 days to sell' do
        it 'decreases price by 4 when price can stay positive' do
          product = Product.new('Super Sale', 0, 4)
          expect(product.update_price.price).to eq(0)
          product = Product.new('Super Sale', 0, 5)
          expect(product.update_price.price).to eq(1)
        end
        it 'sets price at 0 when it can not stay positive' do
          product = Product.new('Super Sale', 0, 1)
          expect(product.update_price.price).to eq(0)
          product = Product.new('Super Sale', 0, 3)
          expect(product.update_price.price).to eq(0)
        end
      end
    end

    context 'when the product is Full Coverage' do
      it 'increases price by 1 when has at least one day left to sell' do
        product = Product.new('Full Coverage', 2, 0)
        expect(product.update_price.price).to eq(1)
      end
      it 'increases price by 2 when has less than one day left to sell' do
        product = Product.new('Full Coverage', 0, 2)
        expect(product.update_price.price).to eq(4)
      end
      it 'does not allow the price to be greater than 50' do
        product = Product.new('Full Coverage', -3, 50)
        expect(product.update_price.price).to eq(50)
        product = Product.new('Full Coverage', -3, 49)
        expect(product.update_price.price).to eq(50)
        product = Product.new('Full Coverage', -3, 48)
        expect(product.update_price.price).to eq(50)
      end
    end

    context 'when the product is Special Full Coverage' do
      it 'increases price by 1 when there are more than 10 days to sell' do
        product = Product.new('Special Full Coverage', 13, 12)
        expect(product.update_price.price).to eq(13)
        product = Product.new('Special Full Coverage', 11, 12)
        expect(product.update_price.price).to eq(13)
      end
      it 'increases price by 2 when there are 6 to 10 days to sell' do
        product = Product.new('Special Full Coverage', 10, 12)
        expect(product.update_price.price).to eq(14)
        product = Product.new('Special Full Coverage', 7, 15)
        expect(product.update_price.price).to eq(17)
        product = Product.new('Special Full Coverage', 6, 14)
        expect(product.update_price.price).to eq(16)
      end
      it 'increases price by 3 when there are 1 to 5 days to sell' do
        product = Product.new('Special Full Coverage', 5, 12)
        expect(product.update_price.price).to eq(15)
        product = Product.new('Special Full Coverage', 3, 15)
        expect(product.update_price.price).to eq(18)
        product = Product.new('Special Full Coverage', 1, 14)
        expect(product.update_price.price).to eq(17)
      end
      it 'keeps the price in 50 when days to sell is positive' do
        product = Product.new('Special Full Coverage', 1, 49)
        expect(product.update_price.price).to eq(50)
        product = Product.new('Special Full Coverage', 7, 49)
        expect(product.update_price.price).to eq(50)
      end
      it 'resets price to zero when days to sell is negative' do
        product = Product.new('Special Full Coverage', 0, 50)
        expect(product.update_price.price).to eq(0)
        product = Product.new('Special Full Coverage', -1, 50)
        expect(product.update_price.price).to eq(0)
      end
    end
  end
end