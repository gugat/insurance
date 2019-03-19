require_relative '../../src/coverages/special_full_coverage'
require_relative '../../src/product'

describe SpecialFullCoverage, type: :model do
  describe '#update_price' do
    subject { SpecialFullCoverage.new }

    it 'increases price by 1 when there are more than 10 days to sell' do
      context = Product.new('Special Full Coverage', 13, 12)
      subject.update_price(context)
      expect(context.price).to eq(13)

      context = Product.new('Special Full Coverage', 11, 12)
      subject.update_price(context)
      expect(context.price).to eq(13)
    end

    it 'increases price by 2 when there are 6 to 10 days to sell' do
      context = Product.new('Special Full Coverage', 10, 12)
      subject.update_price(context)
      expect(context.price).to eq(14)

      context = Product.new('Special Full Coverage', 7, 15)
      subject.update_price(context)
      expect(context.price).to eq(17)

      context = Product.new('Special Full Coverage', 6, 14)
      subject.update_price(context)
      expect(context.price).to eq(16)
    end

    it 'increases price by 3 when there are 1 to 5 days to sell' do
      context = Product.new('Special Full Coverage', 5, 12)
      subject.update_price(context)
      expect(context.price).to eq(15)

      context = Product.new('Special Full Coverage', 3, 15)
      subject.update_price(context)
      expect(context.price).to eq(18)

      context = Product.new('Special Full Coverage', 1, 14)
      subject.update_price(context)
      expect(context.price).to eq(17)
    end

    it 'keeps the price in 50 when days to sell is positive' do
      context = Product.new('Special Full Coverage', 1, 49)
      subject.update_price(context)
      expect(context.price).to eq(50)

      context = Product.new('Special Full Coverage', 7, 49)
      subject.update_price(context)
      expect(context.price).to eq(50)
    end

    it 'resets price to zero when days to sell is negative' do
      context = Product.new('Special Full Coverage', 0, 50)
      subject.update_price(context)
      expect(context.price).to eq(0)

      context = Product.new('Special Full Coverage', -1, 50)
      subject.update_price(context)
      expect(context.price).to eq(0)
    end
  end
end