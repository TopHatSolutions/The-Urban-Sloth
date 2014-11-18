class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def all_categories
    @all_categories ||= Category.all
  end
  helper_method :all_categories

  def all_provinces
    @all_provinces ||= Province.all
  end
  helper_method :all_provinces

  def all_lifestyles
    @all_lifestyles ||= Lifestyle.all
  end
  helper_method :all_lifestyles

  def all_brands
    @all_brands ||= Brand.all
  end
  helper_method :all_brands

  def sale_products
    @sale_products ||= Product.all.where(sale: true)
  end
  helper_method :sale_products
end
