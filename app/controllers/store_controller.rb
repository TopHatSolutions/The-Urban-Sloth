class StoreController < ApplicationController
  def index
    @filterrific = Filterrific.new(Product, params[:filterrific])
    @products = Product.filterrific_find(@filterrific).page(params[:page])
  end

end
