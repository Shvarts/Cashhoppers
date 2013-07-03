require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get current_hops" do
    get :current_hops
    assert_response :success
  end

  test "should get hops_archive" do
    get :hops_archive
    assert_response :success
  end

end
