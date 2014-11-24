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
      ['New Products', 'new_asc'],
      ['Recently Added', 'recently_added_desc'],
      ['Recently Updated', 'recently_updated_asc']
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
        order("products.brand_id #{direction}")
      when /^category_/
        order("products.category_id #{direction}")
      when /^updated_at_/
        order("products.updated_at #{direction}")
      when /^status_/
        order("products.status #{direction}")
      when /^new_/
        where("products.created_at - ?", time.now < 1.day)
      when /^sale_/
        where("products.sale == true")
      when /^recently_updated_/
        where("products.updated_at - ?", time.now < 1.day)
      else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end

  }

  scope :with_category_id, lambda { |category_ids|
    where(:category_id => [*category_ids])
  }

  scope :with_lifestyle_id, lambda { |lifestyle_ids|
    where(:lifestyle_id => [*lifestyle_ids])
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
