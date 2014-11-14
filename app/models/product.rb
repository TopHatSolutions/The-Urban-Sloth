class Product < ActiveRecord::Base
  has_many :product_options
  has_many :options, :through => :options 
end
