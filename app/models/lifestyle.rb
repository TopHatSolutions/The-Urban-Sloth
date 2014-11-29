class Lifestyle < ActiveRecord::Base
  has_many :lifestyle_products
  has_many :products, through: :lifestyle_products

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
end
