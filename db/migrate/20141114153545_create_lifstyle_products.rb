class CreateLifestyleProducts < ActiveRecord::Migration
  def change
    create_table :lifestyle_products do |t|
      t.integer :lifestyle_id
      t.integer :product_id

      t.timestamps
    end
  end
end
