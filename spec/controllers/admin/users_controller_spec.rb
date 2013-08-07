require 'spec_helper'

describe Admin::UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'change_user_role'" do
    it "returns http success" do
      get 'change_user_role'
      response.should be_success
    end
  end

end
