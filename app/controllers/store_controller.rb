class StoreController < ApplicationController

  before_action :get_cart_items

  #paginates_per 8
  def index
    @show_progress = true
    @show_progress_amt = 77
    @cart_subtotal = 0.00





    if session[:visit_count]
      @visit_count = session[:visit_count] + 1
    else
      @visit_count = 1
    end
    session[:visit_count] = @visit_count

    @filterrific = Filterrific.new(Product, params[:filterrific] || session[:filterrific_products])
    @products = Product.filterrific_find(@filterrific).page(params[:page]).per(8)
    @sale_products = Product.where(sale: true)

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

  def cart
    @cart_subtotal = 0.00

    @cart_items = []
    @cart.each do |id|
      @cart_items.push(Product.find(id))
    end

  end

  def checkout
  end

  def product
  end

  def get_cart_items
    if session[:cart]
      @cart = session[:cart]
      @cart_items = []
      @cart.each do |id|
        @cart_items.push(Product.find(id.to_i))
        logger.debug id
      end
    end

  end


  def clear_cart
    session[:cart] = nil
    @cart = nil
    redirect_to :back
  end

  def save_to_cart
    if session[:cart]
      @cart = session[:cart]
      @cart.push(params[:id].to_i)
    else
      @cart = [params[:id].to_i]
    end
    session[:cart] = @cart
    redirect_to :back
  end
end
