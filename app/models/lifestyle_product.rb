class LifestyleProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :lifestyle
end
