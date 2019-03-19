require_relative '../../src/coverages/full_coverage'
require_relative '../../src/product'

describe FullCoverage, type: :model do
  describe '#update_price' do
    subject { FullCoverage.new } 

    it 'increases price by 1 when has at least one day left to sell' do
      context = Product.new('Full Coverage', 2, 0)
      subject.update_price(context)
      expect(context.price).to eq(1)
    end

    it 'increases price by 2 when has less than one day left to sell' do
      context = Product.new('Full Coverage', 0, 2)
      subject.update_price(context)
      expect(context.price).to eq(4)
    end

    it 'does not allow the price to be greater than 50' do
      context = Product.new('Full Coverage', -3, 50)
      subject.update_price(context)
      expect(context.price).to eq(50)
      
      context = Product.new('Full Coverage', -3, 49)
      subject.update_price(context)
      expect(context.price).to eq(50)
      
      context = Product.new('Full Coverage', -3, 48)
      subject.update_price(context)
      expect(context.price).to eq(50)
    end
  end
end