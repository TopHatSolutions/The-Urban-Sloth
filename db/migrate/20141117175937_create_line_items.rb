class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.int :product
      t.decimal :price
      t.int :quantity
      t.int :order_id

      t.timestamps
    end
  end
end
