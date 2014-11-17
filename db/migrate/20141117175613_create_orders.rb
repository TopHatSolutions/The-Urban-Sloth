class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string  :status
      t.decimal :pst_rate
      t.decimal :gst_rate
      t.decimal :hst_rate
      t.decimal :total
      t.decimal :sub_total
      t.int :customer_id

      t.timestamps
    end
  end
end
