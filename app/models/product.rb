class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :product_options
  has_many :options, :through => :options
  has_many :lifestyle_products
  has_many :lifestyles, :through => :lifestyle_products
end
