class Category < ActiveRecord::Base
  has_many :products
  has_many :brands
  validates :name, :description, presence: true

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(action: :reset_filterrific, format: :html) and return
end
