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
        # regular hops
        3.times do
          FactoryGirl.create(:hop)
        end
        # daily hops
        2.times do
          FactoryGirl.create(:hop, :daily_hop => true)
        end
      end

      it 'should return all hops but not daily' do
        hops = Hop.regular.paginate :page => 1
        get :index, @api_key
        assert_equal 3, hops.count
        assigns(:hops).should eq hops
        assert_template 'index'
      end

      it 'should return only daily hops' do
        hops = Hop.daily.paginate :page => 1
        get :daily, @api_key
        assert_equal 2, hops.count
        assigns(:hops).should eq hops
        assert_template 'index'
      end

      it 'should not return closed hops' do
        Hop.regular.last.update_attribute(:close, true)
        hops = Hop.regular.paginate :page => 1
        get :index, @api_key
        assert_equal 2, hops.count
        assigns(:hops).should eq hops
        assert_template 'index'
      end

    end
  end

end
