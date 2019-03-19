require 'active_model'

class Product
  include ActiveModel::Model

  attr_accessor :name, :sellIn, :price
  validates_presence_of :name, :sellIn, :price
end
