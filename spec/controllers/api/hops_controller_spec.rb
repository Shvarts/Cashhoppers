require 'spec_helper'

describe Api::HopsController do

  before(:each) do
    @api_key = FactoryGirl.create(:application).api_key
  end

  it 'should not allow access' do
    get :index
    assert api_key_error == Oj.load(response.body)
  end

  describe 'hops' do
    before(:each) do
      # regular hops
      3.times do
        FactoryGirl.create(:hop)
      end
      # daily hops
      2.times do
        FactoryGirl.create(:hop, :daily => true, :time_start => Time.now)
      end
      # daily hop with yesterday date
      FactoryGirl.create(:hop, :daily => true, :time_start => Date.yesterday)
    end

    it 'should return all hops but not daily' do
      hops = Hop.regular.paginate :page => 1, :per_page => 10
      get :index, :api_key => @api_key
      assert_equal 3, hops.count
      assigns(:hops).should eq hops
      assert_template 'index'
    end

    it 'should not return closed hops' do
      Hop.regular.last.update_attribute(:close, true)
      hops = Hop.regular.paginate :page => 1, :per_page => 10
      get :index, :api_key => @api_key
      assert_equal 2, hops.count
      assigns(:hops).should eq hops
      assert_template 'index'
    end

    it 'should return only daily hops' do
      hops = Hop.daily.paginate :page => 1
      get :daily, :api_key => @api_key
      assert_equal 2, hops.count
      assigns(:hops).should eq hops
      assert_template 'index'
    end
  end

  it 'should return hop tasks' do
    hop = FactoryGirl.create(:hop)
    3.times do
      FactoryGirl.create(:hop_task, :hop => hop)
    end
    get :get_hop_tasks, :hop_id => hop.id, :api_key => @api_key
    assigns(:hop_tasks).should eq hop.hop_tasks
    assert_template 'get_hop_tasks'
  end

end
