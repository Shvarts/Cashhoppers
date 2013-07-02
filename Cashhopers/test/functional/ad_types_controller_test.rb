require 'test_helper'

class AdTypesControllerTest < ActionController::TestCase
  setup do
    @ad_type = ad_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ad_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ad_type" do
    assert_difference('AdType.count') do
      post :create, ad_type: { name: @ad_type.name }
    end

    assert_redirected_to ad_type_path(assigns(:ad_type))
  end

  test "should show ad_type" do
    get :show, id: @ad_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ad_type
    assert_response :success
  end

  test "should update ad_type" do
    put :update, id: @ad_type, ad_type: { name: @ad_type.name }
    assert_redirected_to ad_type_path(assigns(:ad_type))
  end

  test "should destroy ad_type" do
    assert_difference('AdType.count', -1) do
      delete :destroy, id: @ad_type
    end

    assert_redirected_to ad_types_path
  end
end
