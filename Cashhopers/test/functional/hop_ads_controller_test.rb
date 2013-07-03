require 'test_helper'

class HopAdsControllerTest < ActionController::TestCase
  setup do
    @hop_ad = hop_ads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hop_ads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hop_ad" do
    assert_difference('HopAd.count') do
      post :create, hop_ad: { ad_name: @hop_ad.ad_name, contact: @hop_ad.contact, email: @hop_ad.email, phone: @hop_ad.phone, price: @hop_ad.price }
    end

    assert_redirected_to hop_ad_path(assigns(:hop_ad))
  end

  test "should show hop_ad" do
    get :show, id: @hop_ad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hop_ad
    assert_response :success
  end

  test "should update hop_ad" do
    put :update, id: @hop_ad, hop_ad: { ad_name: @hop_ad.ad_name, contact: @hop_ad.contact, email: @hop_ad.email, phone: @hop_ad.phone, price: @hop_ad.price }
    assert_redirected_to hop_ad_path(assigns(:hop_ad))
  end

  test "should destroy hop_ad" do
    assert_difference('HopAd.count', -1) do
      delete :destroy, id: @hop_ad
    end

    assert_redirected_to hop_ads_path
  end
end
