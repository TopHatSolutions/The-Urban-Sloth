class Product < ActiveRecord::Base
  belongs_to :brands
  belongs_to :categories
  has_many :product_options
  has_many :options, :through => :options
  has_many :lifestyle_products
  has_many :lifestyles, :through => :lifestyle_products
end
