require 'spec_helper'

describe Api::HopsController do
  describe 'index' do
    it 'should not allow access' do
      get :index
      error = {:errors => 'Bad api key', :success => false, :status => 401}
      assert error == Oj.load(response.body)
    end

    describe 'return hop' do
      before(:each) do
        @api_key = {:api_key => FactoryGirl.create(:application).api_key}
        3.times do
          FactoryGirl.create(:hop)
        end
        FactoryGirl.create(:hop, :daily => true)
      end

      it 'should return all hops' do
        get :index, @api_key

      end
    end
  end

end
