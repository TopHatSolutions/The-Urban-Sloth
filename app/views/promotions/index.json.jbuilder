json.array!(@promotions) do |promotion|
  json.extract! promotion, :id, :name, :description, :date_start, :date_end
  json.url promotion_url(promotion, format: :json)
end
