require 'spec_helper'

describe Friendship do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:user)
  end

  it 'should create request' do
    Friendship.request(@user, @friend)
    assert Friendship.exists?(@user, @friend)
    assert_status @user, @friend, 'pending'
    assert_status @friend, @user, 'requested'
  end

  it 'should accept request' do
    Friendship.request(@user, @friend)
    Friendship.accept(@user, @friend)
    assert Friendship.exists?(@user, @friend)
    assert_status @user, @friend, 'accepted'
    assert_status @friend, @user, 'accepted'
  end

  it 'should breakup request' do
    Friendship.request(@user, @friend)
    Friendship.breakup(@user, @friend)
    assert !Friendship.exists?(@user, @friend)
  end

  private

  def assert_status(user, friend, status)
    friendship = Friendship.find_by_user_id_and_friend_id(user, friend)
    assert_equal status, friendship.status
  end

end