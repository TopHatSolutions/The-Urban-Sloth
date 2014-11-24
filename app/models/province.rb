class Province < ActiveRecord::Base
  has_many :customers

  validates :name, :abbreviation, :gst_rate, :pst_rate, :hst_rate, presence: true
  validates :gst_rate, :pst_rate, :hst_rate, numericality: true
end
