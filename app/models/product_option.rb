class ProductOption < ActiveRecord::Base
  belongs_to :products
  belongs_to :options
end
