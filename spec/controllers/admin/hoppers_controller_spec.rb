require 'spec_helper'

describe Admin::HoppersController do

  describe "GET 'find_hopper'" do
    it "returns http success" do
      get 'find_hopper'
      response.should be_success
    end
  end

  describe "GET 'hopper_list'" do
    it "returns http success" do
      get 'hopper_list'
      response.should be_success
    end
  end

end
