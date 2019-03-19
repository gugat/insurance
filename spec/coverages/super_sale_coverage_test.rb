require_relative '../../src/coverages/super_sale_coverage'
require_relative '../../src/product'

describe SuperSaleCoverage, type: :model do
  subject { SuperSaleCoverage.new }
  describe '#update_price' do
    it 'decreases price by 2 when has many days to sell' do
      context = Product.new('Super Sale', 5, 7)
      subject.update_price(context)
      expect(context.price).to eq(5)

      context = Product.new('Super Sale', 3, 6)
      subject.update_price(context)
      expect(context.price).to eq(4)
    end

    it 'does not decrease price when has less than 0 days to sell' do
      context = Product.new('Super Sale', -1, 0)
      subject.update_price(context)
      expect(context.price).to eq(0)
    end

    context 'when has 0 days to sell' do
      it 'decreases price by 4 when price can stay positive' do
        context = Product.new('Super Sale', 0, 4)
        subject.update_price(context)
        expect(context.price).to eq(0)

        context = Product.new('Super Sale', 0, 5)
        subject.update_price(context)
        expect(context.price).to eq(1)
      end

      it 'sets price at 0 when it can not stay positive' do
        context = Product.new('Super Sale', 0, 1)
        subject.update_price(context)
        expect(context.price).to eq(0)
        
        context = Product.new('Super Sale', 0, 3)
        subject.update_price(context)
        expect(context.price).to eq(0)
      end
    end
  end
end
