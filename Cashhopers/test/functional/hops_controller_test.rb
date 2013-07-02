require 'test_helper'

class HopsControllerTest < ActionController::TestCase
  setup do
    @hop = hops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hop" do
    assert_difference('Hop.count') do
      post :create, hop: { contact_email: @hop.contact_email, contact_phone: @hop.contact_phone, hop_code: @hop.hop_code, hop_items: @hop.hop_items, hop_price: @hop.hop_price, jackpot: @hop.jackpot, name: @hop.name, producer_contact: @hop.producer_contact, producer_id: @hop.producer_id, time_end: @hop.time_end, time_start: @hop.time_start }
    end

    assert_redirected_to hop_path(assigns(:hop))
  end

  test "should show hop" do
    get :show, id: @hop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hop
    assert_response :success
  end

  test "should update hop" do
    put :update, id: @hop, hop: { contact_email: @hop.contact_email, contact_phone: @hop.contact_phone, hop_code: @hop.hop_code, hop_items: @hop.hop_items, hop_price: @hop.hop_price, jackpot: @hop.jackpot, name: @hop.name, producer_contact: @hop.producer_contact, producer_id: @hop.producer_id, time_end: @hop.time_end, time_start: @hop.time_start }
    assert_redirected_to hop_path(assigns(:hop))
  end

  test "should destroy hop" do
    assert_difference('Hop.count', -1) do
      delete :destroy, id: @hop
    end

    assert_redirected_to hops_path
  end
end
