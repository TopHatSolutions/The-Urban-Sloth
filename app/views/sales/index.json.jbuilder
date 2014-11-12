json.array!(@sales) do |sale|
  json.extract! sale, :id, :name, :percentage, :start_date, :finish_date
  json.url sale_url(sale, format: :json)
end
