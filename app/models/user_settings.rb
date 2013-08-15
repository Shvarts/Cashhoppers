class UserSettings < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_invite, :friend_invite_accept, :end_of_hop, :comment, :like
  before_save :init_settings

  private

  def init_settings
    friend_invite = 1
    friend_invite_accept = 1
    end_of_hop = 1
    comment = 1
    like = 1
  end

end
