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

    amount = 0
    if name == 'Low Coverage'
      if @sellIn.zero?
        amount = -2
      elsif @sellIn > 0
        amount = -1
      end
      new_price = @price + amount
      @price = new_price.negative? ? 0 : new_price
    elsif name == 'Super Sale'
      if @sellIn.zero?
        amount = -2 * 2
      elsif @sellIn > 0
        amount = -1 * 2
      end
      new_price = @price + amount
      @price = new_price.negative? ? 0 : new_price
    elsif name == 'Full Coverage'
      if @sellIn > 0
        amount = 1
      else 
        amount = 2
      end
      new_price = @price + amount
      @price = new_price >= 50 ? 50 : new_price
    elsif name == 'Special Full Coverage'
      if @sellIn <= 0
        amount = -@price
      elsif @sellIn.between?(1,5)
        amount = 3
      elsif @sellIn.between?(6,10)
        amount = 2
      else
        amount = 1
      end
      new_price = @price + amount
      @price = new_price >= 50 ? 50 : new_price
    end
    # Decrease days to sell
    @sellIn -= 1
    self
  end

end
