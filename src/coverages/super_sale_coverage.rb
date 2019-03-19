class SuperSaleCoverage
  def update_price(context)
    if context.sellIn <= 0
      amount = -2 * 2
    elsif context.sellIn > 0
      amount = -1 * 2
    end
    new_price = context.price + amount
    context.price = new_price <= 0 ? 0 : new_price
  end
end