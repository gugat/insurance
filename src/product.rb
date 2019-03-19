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
    return self if name == 'Mega Coverage'

    if name == 'Low Coverage'
      amount = 0
      if @sellIn.zero?
        amount = -2
      elsif @sellIn > 0
        amount = -1
      end
      new_price = @price + amount
      @price = new_price.negative? ? 0 : new_price
    end
    # Decrease days to sell
    @sellIn -= 1
    self
  end

end
