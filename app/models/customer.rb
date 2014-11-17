class Customer < ActiveRecord::Base
  belongs_to :province
  has_many :orders
  has_many :line_items, :through => :orders
end
