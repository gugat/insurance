require 'active_model'

# Car Insurance business unit
class CarInsurance
  include ActiveModel::Model

  attr_accessor :products
  validates_presence_of :products

  def initialize(products)
    @products = products
  end

  def updatePrice
    products.map(&:update_price)
    products
  end
end
