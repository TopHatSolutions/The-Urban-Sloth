class Lifestyle < ActiveRecord::Base
  has_many :lifestyle_products
  has_many :products, :through => :lifestyle_products



  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

  @filterrific.select_options={
    with_lifestyle_id: Lifestyle.options_for_select
  }

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(action: :reset_filterrific, format: :html) and return

end
