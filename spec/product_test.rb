require_relative '../src/product'
require_relative 'spec_helper'

RSpec.describe Product, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sellIn) }
  it { should validate_presence_of(:price) }
end