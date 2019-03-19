class SuperSaleCoverage
  def update_price(context)
    amount = context.sellIn <= 0 ? -2 * 2 : -1 * 2
    new_price = context.price + amount
    context.price = new_price <= 0 ? 0 : new_price
  end
end