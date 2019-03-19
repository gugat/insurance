class FullCoverage
  def update_price(context)
    amount = context.sellIn > 0 ? 1 : 2
    new_price = context.price + amount
    context.price = new_price >= 50 ? 50 : new_price
  end
end