require_relative '../src/car_insurance'
require_relative '../src/product'
require_relative 'spec_helper'

describe '30DaysSpec' do
  it 'should print price updates for 30 days' do
    productsAtDayZero = [
      Product.new('Medium Coverage', 10, 20),
      Product.new('Full Coverage', 2, 0),
      Product.new('Low Coverage', 5, 7),
      Product.new('Mega Coverage', 0, 80),
      Product.new('Mega Coverage', -1, 80),
      Product.new('Special Full Coverage', 15, 20),
      Product.new('Special Full Coverage', 10, 49),
      Product.new('Special Full Coverage', 5, 49),
      Product.new('Super Sale', 3, 6)
    ]

    car_insurance = CarInsurance.new(productsAtDayZero)

    (1..30).each do |i|
      puts("Day #{i}")
      puts('name, sellIn, price')
      car_insurance.updatePrice.map(&:log)
      puts ''
    end
  end
end
