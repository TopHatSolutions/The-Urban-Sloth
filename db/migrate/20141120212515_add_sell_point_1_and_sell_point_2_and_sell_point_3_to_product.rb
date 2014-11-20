class AddSellPoint1AndSellPoint2AndSellPoint3ToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sell_point_1, :string
    add_column :products, :sell_point_2, :string
    add_column :products, :sell_point_3, :string
  end
end
