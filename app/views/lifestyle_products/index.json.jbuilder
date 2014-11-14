json.array!(@lifestyle_products) do |lifestyle_product|
  json.extract! lifestyle_product, :id, :lifestyle_id, :product_id
  json.url lifestyle_product_url(lifestyle_product, format: :json)
end
