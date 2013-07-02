require 'test_helper'

class Admin::ApplicationsControllerTest < ActionController::TestCase
  setup do
    @admin_application = admin_applications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_application" do
    assert_difference('Admin::Application.count') do
      post :create, admin_application: { api_key: @admin_application.api_key, description: @admin_application.description, name: @admin_application.name }
    end

    assert_redirected_to admin_application_path(assigns(:admin_application))
  end

  test "should show admin_application" do
    get :show, id: @admin_application
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_application
    assert_response :success
  end

  test "should update admin_application" do
    put :update, id: @admin_application, admin_application: { api_key: @admin_application.api_key, description: @admin_application.description, name: @admin_application.name }
    assert_redirected_to admin_application_path(assigns(:admin_application))
  end

  test "should destroy admin_application" do
    assert_difference('Admin::Application.count', -1) do
      delete :destroy, id: @admin_application
    end

    assert_redirected_to admin_applications_path
  end
end
