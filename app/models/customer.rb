class Customer < ActiveRecord::Base
  belongs_to :province
  has_many :orders

  validates :full_name, :phone_number, :street_address, :postal_code, :email_address, :province_id, presence: true
end
