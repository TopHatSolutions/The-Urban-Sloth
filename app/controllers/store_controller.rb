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
    if session[:customer_id]
      @customer = Customer.find(session[:customer_id].to_i)
    end

    @cart_subtotal = 0.00

    @cart_items = []
    @cart.each do |id|
      @cart_items.push(Product.find(id))
    end
    session[:order_subtotal] = @cart_subtotal

  end

  def checkout
    if session[:customer_id]
      @customer = Customer.find(session[:customer_id])
      @cart_items = []
      @cart = session[:cart]
      @cart.each do |id|
        @cart_items.push(Product.find(id))
      end

      order = @customer.orders.build

      order.status = 'new'
      order.pst_rate = @customer.province.pst_rate
      order.gst_rate = @customer.province.gst_rate
      order.hst_rate = @customer.province.hst_rate
      order.sub_total = session[:order_subtotal]

      order.total = order.sub_total + (order.sub_total*order.pst_rate) + (order.sub_total*order.gst_rate) + (order.sub_total*order.hst_rate)

      if order.save
        puts "Order Saved."
        @cart_items.each do |product|

          #puts product.name
          line_item = order.line_items.build
          line_item.product = product
          line_item.quantity = 1
          line_item.price = product.price

          if line_item.save
            puts "#{product.name} Saved."
          else
            puts "Error: "
            line_item.errors.messages.each do |column, errors|
              errors.each do |error|
                puts "The #{column} property #{error}."
              end
            end
          end
        end
      else
        puts "Error: "
        order.errors.messages.each do |column, errors|
          errors.each do |error|
            puts "The #{column} property #{error}."
          end
        end
      end

    else
      @customer = Customer.new
    end
  end

  def checkout_customer
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        session[:customer_id] = @customer.id
        format.html { redirect_to cart_path, notice: 'You Have Successfully Signed Up.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
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

  private
  def customer_params
    params.require(:customer).permit(:full_name, :phone_number, :email_address, :street_address, :postal_code, :province_id)
  end
end
