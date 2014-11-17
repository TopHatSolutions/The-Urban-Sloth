json.array!(@orders) do |order|
  json.extract! order, :id, :belongs_to, :has_many, :status, :pst_rate, :gst_rate, :hst_rate, :total, :sub_total, :customer_id
  json.url order_url(order, format: :json)
end
