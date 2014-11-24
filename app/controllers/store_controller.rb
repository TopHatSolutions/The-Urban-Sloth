class StoreController < ApplicationController
  #paginates_per 8
  def index
    @filterrific = Filterrific.new(Product, params[:filterrific] || session[:filterrific_products])
    @products = Product.filterrific_find(@filterrific).page(params[:page]).per(8)


    @filterrific.select_options={
      with_lifestyle_id: Lifestyle.options_for_select,
      with_category_id: Category.options_for_select,
      sorted_by: Product.options_for_select
    }

    session[:filterrific_products] = @filterrific.to_hash



    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(action: :reset_filterrific, format: :html) and return

  end
end
