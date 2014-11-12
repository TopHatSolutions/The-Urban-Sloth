json.array!(@customers) do |customer|
  json.extract! customer, :id, :full_name, :phone_number, :email_address, :street_address, :postal_code
  json.url customer_url(customer, format: :json)
end
