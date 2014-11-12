json.array!(@provinces) do |province|
  json.extract! province, :id, :name, :abbreviation, :gst_rate, :pst_rate, :hst_rate
  json.url province_url(province, format: :json)
end
