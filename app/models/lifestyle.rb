class Lifestyle < ActiveRecord::Base
  has_many :lifestyle_products
  has_many :products, :through => :lifestyle_products
end
