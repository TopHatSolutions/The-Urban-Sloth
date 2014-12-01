class StoreController < ApplicationController
  before_action :grab_cart_items

  # paginates_per 8
  def index
    @show_progress = true
    @show_progress_max = 115
    @show_progress_goal = 100
    @show_progress_amt = 103
    @show_progress_percent = ((@show_progress_amt.to_f / @show_progress_max) * 100).to_i
    @show_progress_left_for_possible = (@show_progress_goal - @show_progress_percent).round
    @show_progress_left_for_goal = @show_progress_goal - @show_progress_amt
    @cart_subtotal = 0.00

    @sale_products = Product.where(sale: true)

    if session[:visit_count]
      @visit_count = session[:visit_count] + 1
    else
      @visit_count = 1
    end
    session[:visit_count] = @visit_count

    @filterrific = Filterrific.new(Product, params[:filterrific] || session[:filterrific_products])
    @products = Product.filterrific_find(@filterrific).page(params[:page]).per(8)
    @sale_products = Product.where(sale: true)

    @filterrific.select_options = {
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
      Logger "Had to reset filterrific params: #{ e.message }"
      redirect_to(action: :reset_filterrific, format: :html) && return
  end

  def cart
    @cart_subtotal = session[:subtotal]
    @customer = Customer.find(session[:customer_id].to_i) unless session[:customer_id].nil?

    #@cart_items = []
    #if @cart
    #  @cart.each do |id|
    #    @cart_items.push(Product.find(id))
    #  end
    #end
    #session[:subtotal] = @cart_subtotal
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

      order.total = order.sub_total +
        (order.sub_total * order.pst_rate) +
        (order.sub_total * order.gst_rate) +
        (order.sub_total * order.hst_rate)
      respond_to do |format|
        if order.save
          # Logger 'Order Saved.'
          @cart_items.each do |product|

            # Logger product.name
            line_item = order.line_items.build
            line_item.product = product
            line_item.quantity = 1
            line_item.price = product.price

            if line_item.save
              # Logger "#{product.name} Saved."
            else
              # Logger 'Error: '
              line_item.errors.messages.each do |column, errors|
                errors.each do |error|
                  Logger "The #{column} property #{error}."
                end
              end
            end
          end
          session[:cart] = nil
          session[:customer_id] = nil
          format.html { redirect_to root_path, notice: 'You Have Successfully Placed Your Order.' }
          format.json { render :show, status: :created, location: @customer }
        else
          # Logger 'Error: '
          order.errors.messages.each do |column, errors|
            errors.each do |error|
              # Logger "The #{column} property #{error}."
            end
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
    @product = Product.find_by_slug(params[:id])
    @cart_subtotal = 0.0
    if session[:subtotal]
      @cart_subtotal = session[:subtotal]
    end
  end

  def grab_cart_items
    if session[:cart]
      @subtotal = 0.00
      @cart = session[:cart]
      @cart_items = []
      @cart.each do |id|
        @id = id['id']
        item = Product.find(@id)
        @cart_items.push({item: item, qty: id['qty']})
        @subtotal += item.price * id['qty']
      end
      session[:subtotal] = @subtotal
    else
      return 'No Items in Cart'
    end
  end

  def clear_cart
    session[:cart] = nil
    session[:subtotal] = nil
    @cart = nil
    redirect_to :back
  end

  def save_to_cart
    @id = params[:id].to_i
    if session[:cart]
      @cart = session[:cart]
      if @cart.any? {|i| i['id'] == @id}
        @cart.each do |i|
          if i['id'] == @id
            i['qty'] += 1
          end
        end
      else
        @cart.push({:id => @id, :qty => 1})
      end

    else
      @cart = []
      @cart.push({:id => @id, :qty => 1})
    end
    session[:cart] = @cart
    redirect_to :back
  end

  private

  def customer_params
    params.require(:customer).permit(
      :full_name,
      :phone_number,
      :email_address,
      :street_address,
      :postal_code,
      :province_id
    )
  end
end
