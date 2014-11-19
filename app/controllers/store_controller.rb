class StoreController < ApplicationController
  def index
    @filterrific = Filterrific.new(Product, params[:filterrific])
    @products = Product.filterrific_find(@filterrific).page(params[:page])


    @filterrific.select_options={
      with_lifestyle_id: Lifestyle.options_for_select,
      with_category_id: Category.options_for_select
    }


    respond_to do |format|
      format.html
      format.js
    end


  end
end
