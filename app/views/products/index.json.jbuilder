json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :stock_quantity
  json.url product_url(product, format: :json)
end
