require 'test_helper'

class lifestyleProductsControllerTest < ActionController::TestCase
  setup do
    @lifestyle_product = lifestyle_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lifestyle_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lifestyle_product" do
    assert_difference('lifestyleProduct.count') do
      post :create, lifestyle_product: { lifestyle_id: @lifestyle_product.lifestyle_id, product_id: @lifestyle_product.product_id }
    end

    assert_redirected_to lifestyle_product_path(assigns(:lifestyle_product))
  end

  test "should show lifestyle_product" do
    get :show, id: @lifestyle_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lifestyle_product
    assert_response :success
  end

  test "should update lifestyle_product" do
    patch :update, id: @lifestyle_product, lifestyle_product: { lifestyle_id: @lifestyle_product.lifestyle_id, product_id: @lifestyle_product.product_id }
    assert_redirected_to lifestyle_product_path(assigns(:lifestyle_product))
  end

  test "should destroy lifestyle_product" do
    assert_difference('lifestyleProduct.count', -1) do
      delete :destroy, id: @lifestyle_product
    end

    assert_redirected_to lifestyle_products_path
  end
end
