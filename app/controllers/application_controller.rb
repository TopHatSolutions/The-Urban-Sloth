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
end
