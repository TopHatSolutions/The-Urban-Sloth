Customer.create!([
  {full_name: "Andrew Gillespie", phone_number: "2045109275", email_address: "gillespie.andrewc@gmail.com", street_address: "91 Fulton st", postal_code: "r2n4c1", province_id: 1},
  {full_name: "Andrew Gillespie", phone_number: "2045109275", email_address: "gillespie.andrewc@gmail.com", street_address: "91 Fulton st", postal_code: "r2n4c1", province_id: 1},
  {full_name: "Andrew Gillespie", phone_number: "2045109275", email_address: "gillespie.andrewc@gmail.com", street_address: "91 Fulton st", postal_code: "r2n4c1", province_id: 1}
])
Lifestyle.create!([
  {name: "The Gamer", description: "all the things!"}
])
LifestyleProduct.create!([
  {lifestyle_id: 1, product_id: 1}
])
LineItem.create!([
  {product_id: 9, price: "125.99", quantity: 1, order_id: 3},
  {product_id: 9, price: "125.99", quantity: 1, order_id: 6},
  {product_id: 8, price: "6.49", quantity: 1, order_id: 6}
])
Option.create!([
  {option_type: "Color", option_value: "Blue", option_price: nil, name: "Color: Blue"}
])
Order.create!([
  {status: "new", pst_rate: "0.08", gst_rate: "0.05", hst_rate: "0.0", total: "142.3687", sub_total: "125.99", customer_id: 2},
  {status: "new", pst_rate: "0.08", gst_rate: "0.05", hst_rate: "0.0", total: "157.0361", sub_total: "138.97", customer_id: 3}
])
Page.create!([
  {name: "About", content: "b"},
  {name: "Contact", content: "b"}
])
ProductOption.create!([
  {product_id: 1, option_id: 1}
])
