json.array!(@options) do |option|
  json.extract! option, :id, :option_type, :option_value, :option_price
  json.url option_url(option, format: :json)
end
