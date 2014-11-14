class Product < ActiveRecord::Base
  belongs_to :brands
  belongs_to :categories
  has_many :product_options
  has_many :options, :through => :options
end
