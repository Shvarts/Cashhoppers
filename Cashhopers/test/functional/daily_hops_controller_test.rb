require 'test_helper'

class DailyHopsControllerTest < ActionController::TestCase
  setup do
    @daily_hop = daily_hops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_hops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_hop" do
    assert_difference('DailyHop.count') do
      post :create, daily_hop: { jackpot: @daily_hop.jackpot, name: @daily_hop.name, points: @daily_hop.points, share_point: @daily_hop.share_point, text_for_item: @daily_hop.text_for_item, users: @daily_hop.users, winner: @daily_hop.winner }
    end

    assert_redirected_to daily_hop_path(assigns(:daily_hop))
  end

  test "should show daily_hop" do
    get :show, id: @daily_hop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_hop
    assert_response :success
  end

  test "should update daily_hop" do
    put :update, id: @daily_hop, daily_hop: { jackpot: @daily_hop.jackpot, name: @daily_hop.name, points: @daily_hop.points, share_point: @daily_hop.share_point, text_for_item: @daily_hop.text_for_item, users: @daily_hop.users, winner: @daily_hop.winner }
    assert_redirected_to daily_hop_path(assigns(:daily_hop))
  end

  test "should destroy daily_hop" do
    assert_difference('DailyHop.count', -1) do
      delete :destroy, id: @daily_hop
    end

    assert_redirected_to daily_hops_path
  end
end
