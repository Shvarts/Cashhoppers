require 'spec_helper'

describe Api::AdsController do

  describe 'send_ad' do

    it 'should not allow access' do
      get :index
      assert api_key_error == Oj.load(response.body)
    end

    describe 'get ads' do
      before(:each) do
        @api_key = FactoryGirl.create(:application).api_key
      end

      it 'should find ads by ad_type (1 ad)' do
        ad = FactoryGirl.create(:ad, :type_add => 'today')

        get :index,
            :ad_type => 'today',
            :api_key => @api_key

        assigns(:ads).should eq [ad]
        assert_template 'index'
      end

      it 'should find ads by ad_type (3 ads)' do

        3.times do
          FactoryGirl.create(:ad, :type_add => 'start')
        end

        ads = Ad.find_all_by_type_add('start')

        get :index,
            :ad_type => 'start',
            :api_key => @api_key

        assigns(:ads).should eq ads
        assert_template 'index'
      end

      it 'should find ads by hop_id' do
        ad = FactoryGirl.create(:ad_with_hop)
        get :index,
            :hop_id => ad.hop.id,
            :api_key => @api_key

        assigns(:ads).should eq [ad]
        assert_template 'index'
      end
    end
  end
end