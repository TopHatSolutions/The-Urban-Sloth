require 'test_helper'

class LifestylesControllerTest < ActionController::TestCase
  setup do
    @lifestyle = lifestyles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lifestyles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lifestyle" do
    assert_difference('Lifestyle.count') do
      post :create, lifestyle: { description: @lifestyle.description, name: @lifestyle.name }
    end

    assert_redirected_to lifestyle_path(assigns(:lifestyle))
  end

  test "should show lifestyle" do
    get :show, id: @lifestyle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lifestyle
    assert_response :success
  end

  test "should update lifestyle" do
    patch :update, id: @lifestyle, lifestyle: { description: @lifestyle.description, name: @lifestyle.name }
    assert_redirected_to lifestyle_path(assigns(:lifestyle))
  end

  test "should destroy lifestyle" do
    assert_difference('Lifestyle.count', -1) do
      delete :destroy, id: @lifestyle
    end

    assert_redirected_to lifestyles_path
  end
end
