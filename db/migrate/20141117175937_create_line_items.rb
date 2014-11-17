class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product
      t.decimal :price
      t.integer :quantity
      t.integer :order_id

      t.timestamps
    end
  end
end
