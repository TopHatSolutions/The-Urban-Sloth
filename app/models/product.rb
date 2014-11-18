class Product < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  has_many :product_options
  has_many :options, :through => :product_options
  has_many :lifestyle_products
  has_many :lifestyles, :through => :lifestyle_products
  mount_uploader :image, ImageUploader

  filterrific(
    default_settings: { sorted_by: 'created_at_desc' },
    filter_names: [
      :search_query,
      :sorted_by
      #:with_country_id,
      #:with_created_at_gte
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
      else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end

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
      *terms.map { |e| [e] * num_or_conds }.flatten
    )

  }
end
