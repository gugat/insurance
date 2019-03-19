require_relative '../src/coverager'
require_relative '../src/coverages/mega_coverage'
require_relative '../src/coverages/default_coverage'

describe Coverager do
  describe 'self.for' do
    context 'when the type exists' do
      subject { Coverager.for('Mega Coverage') } 
      it 'returns an instance of the requested coverage' do
        expect(subject).to be_a MegaCoverage
      end
    end

    context 'when the type does not exist' do
      subject { Coverager.for('Woohooo Coverage') } 
      it 'returns an instance of the default coverage' do
        expect(subject).to be_a DefaultCoverage
      end
    end

    context 'when the right type does not have the right structure' do
      subject { Coverager.for('Mega') } 
      it 'adds Coverage to the type and returns the requested coverage' do
        expect(subject).to be_a MegaCoverage
      end
    end
  end
  
end
