class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.integer :product_id
      t.integer :option_id

      t.timestamps
    end
  end
end
