class LifestyleProduct < ActiveRecord::Base
  belongs_to :products
  belongs_to :lifestyles
end
