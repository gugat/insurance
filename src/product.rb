require 'active_model'

class Product
  include ActiveModel::Model

  attr_accessor :name, :sellIn, :price
  validates_presence_of :name, :sellIn, :price

  def initialize(name, sellIn, price)
    @name = name
    @sellIn = sellIn
    @price = price
  end

  def update_price
    self if name == 'Mega Coverage'
  end
end
