class Product < ActiveRecord::Base
  acts_as_cartable

  attr_accessible :name, :price
end
