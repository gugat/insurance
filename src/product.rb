require 'active_model'
require_relative './coverager'

class Product
  include ActiveModel::Model

  attr_accessor :name, :sellIn, :price
  validates_presence_of :name, :sellIn, :price

  def initialize(name, sellIn, price)
    @name = name
    @sellIn = sellIn
    @price = price
  end

  def log
    puts "#{@name}, #{@sellIn}, #{@price}"
  end

  def update_price
    Coverager.for(@name).update_price(self)
    @sellIn -= 1 if @name != 'Mega Coverage'
  end
end
