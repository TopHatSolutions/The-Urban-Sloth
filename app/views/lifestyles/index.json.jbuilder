json.array!(@lifestyles) do |lifestyle|
  json.extract! lifestyle, :id, :name, :description
  json.url lifestyle_url(lifestyle, format: :json)
end
