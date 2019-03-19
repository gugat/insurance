class SpecialFullCoverage
  def update_price(context)
    if context.sellIn <= 0
      amount = -context.price
    elsif context.sellIn.between?(1,5)
      amount = 3
    elsif context.sellIn.between?(6,10)
      amount = 2
    else
      amount = 1
    end
    new_price = context.price + amount
    context.price = new_price >= 50 ? 50 : new_price
  end
end

