class Product < ActiveRecord::Base
  belongs_to :brands
  has_many :product_options
  has_many :options, :through => :options
end
