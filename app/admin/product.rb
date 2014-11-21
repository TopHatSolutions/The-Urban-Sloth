ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :brand_id, :category_id, :image, :sale, :sell_point_1, :sell_point_2, :sell_point_3

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs do
      f.input :category
      f.input :brand
      f.input :name
      f.input :price
      f.input :stock_quantity
      f.input :sell_point_1
      f.input :sell_point_2
      f.input :sell_point_3
      f.input :description
      f.input :image
      f.input :sale
    end
    f.actions
  end
end
