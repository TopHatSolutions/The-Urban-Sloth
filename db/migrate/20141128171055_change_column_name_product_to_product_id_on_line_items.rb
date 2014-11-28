class ChangeColumnNameProductToProductIdOnLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :product, :product_id
  end
end
