require_relative '../../src/coverages/default_coverage'
require_relative '../../src/product'

describe DefaultCoverage, type: :model do
  describe '#update_price' do
    subject { DefaultCoverage.new }
    it 'decreases price by 1 when has at least one day to sell' do
      context = Product.new('Low Coverage', 5, 7)
      subject.update_price(context)
      expect(context.price).to eq(6)

      context = Product.new('Low Coverage', 1, 7)
      subject.update_price(context)
      expect(context.price).to eq(6)
    end

    it 'decreases price by 2 when does not have days to sell' do
      context = Product.new('Low Coverage', -5, 5)
      subject.update_price(context)
      expect(context.price).to eq(3)

      context = Product.new('Low Coverage', -1, 3)
      subject.update_price(context)
      expect(context.price).to eq(1)
    end
    
    it 'sets price at 0 when it can not stay positive' do
      context = Product.new('Low Coverage', -13, 2)
      subject.update_price(context)
      expect(context.price).to eq(0)

      context = Product.new('Low Coverage', 0, 2)
      subject.update_price(context)
      expect(context.price).to eq(0)
    end
  end
end