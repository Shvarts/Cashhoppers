require 'spec_helper'

describe Api::SettingsController do

  describe "GET 'get'" do
    it "returns http success" do
      get 'get'
      response.should be_success
    end
  end

  describe "GET 'set'" do
    it "returns http success" do
      get 'set'
      response.should be_success
    end
  end

end
