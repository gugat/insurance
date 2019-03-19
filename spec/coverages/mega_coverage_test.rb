require_relative '../../src/coverages/mega_coverage'
require_relative '../../src/product'

describe MegaCoverage, type: :model do
  describe '#update_price' do
    subject { MegaCoverage.new }
    let(:context) { Product.new('Mega Coverage', -1, 80) }

    it 'never decreases price' do
      subject.update_price(context)
      expect(context.price).to eq(80)
    end

    it 'never decreases days to sell' do
      subject.update_price(context)
      expect(context.sellIn).to eq(-1)
    end
  end
end