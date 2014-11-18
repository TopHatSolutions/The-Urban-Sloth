class AddSaleToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale, :boolean
  end
end
