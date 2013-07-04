require 'spec_helper'

describe Api::SessionsController do
  # TODO: need coverage all code
  describe 'sign up' do
    before(:each) do
      device_mapping
    end

    it 'should restrict access' do
      post :sign_up
      assert_equal api_key_error, Oj.load(response.body)
    end

    it 'should create user' do
      assert !User.last
      @api_key = FactoryGirl.create(:application).api_key
      params = FactoryGirl.attributes_for(:user)
      params[:api_key] = @api_key
      post :sign_up, params
      assert User.last
      assert_equal 'Check your email and confirm registration.', Oj.load(response.body)[:message]
    end
  end

end
