class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :product_options
  has_many :options, :through => :product_options
  has_many :lifestyle_products
  has_many :lifestyles, :through => :lifestyle_products
  has_many :line_items
  has_many :orders, :through => :line_items
  mount_uploader :image, ImageUploader
  validates :name, :category, :price, :stock_quantity, :sell_point_1, :sell_point_2, :sell_point_3, presence: true
  validates :price, :stock_quantity, numericality: true

  def self.options_for_select
    [
      ['All Products'],
      ['New Products Only', 'new_asc'],
      ['Sale Items Only', 'sale_asc'],
      ['Recently Updated Only', 'recently_updated_asc'],
      ['Newest First','created_at_desc'],
      ['Oldest First','created_at_asc'],
      ['Product Name [a-z]','name_asc'],
      ['Product Name [z-a]','name_desc'],
      ['Brand [a-z]','brand_name_asc'],
      ['Category Name [a-z]','category_name_asc'],
      ['Category Name [z-a]','category_name_desc'],
      ['Recently Updated First','updated_at_desc'],
      ['Recently Updated Last','updated_at_asc'],
    ]
  end

  filterrific(
    default_settings: { sorted_by: 'created_at_desc' },
    filter_names: [
      :search_query,
      :sorted_by,
      :filtered_by,
      :with_lifestyle_id,
      :with_category_id,
      :with_brand_id
    ]
  )


  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'

    case sort_key.to_s
      when /^created_at_/
        order("products.created_at #{direction}")
      when /^name_/
        order("products.name #{direction}")
      when /^price_/
        order("products.price #{direction}")
      when /^brand_/
        order("products.brand_name #{direction}")
      when /^category_/
        order("products.category_name #{direction}")
      when /^updated_at_/
        order("products.updated_at #{direction}")
      when /^new_/
        where("products.created_at > ?",  1.days.ago)
      when /^sale_/
        where("products.sale == true")
      when /^recently_updated_/
        where("products.updated_at > ?", 1.days.ago)
      else
        all
    end

  }

  scope :with_category_id, lambda { |category_ids|
    where(:category_id => [*category_ids])
  }

  scope :with_lifestyle_id, lambda { |lifestyle_ids|
    where(:lifestyle => [*lifestyle_ids])
  }

  scope :with_brand_id, lambda { |brand_ids|
    where(:brand_id => [*brand_ids])
  }

  scope :search_query, lambda { |query|
    return nil if query.blank?

    terms = query.downcase.split(/\s+/)

    terms = terms.map do |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    end

    number_of_ors = 2
    where(
    terms.map { |term|
      "(LOWER(products.name) LIKE ? OR LOWER(products.description) LIKE ?)"
    }.join(' AND '),
      *terms.map { |e| [e] * number_of_ors }.flatten
    )
  }
end
