class FullCoverage
  def update_price(context)
    if context.sellIn > 0
      amount = 1
    else 
      amount = 2
    end
    new_price = context.price + amount
    context.price = new_price >= 50 ? 50 : new_price
  end
end