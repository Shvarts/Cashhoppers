class UserSettings < ActiveRecord::Base
  belongs_to :user
  attr_accessible :friend_invite,
                  :friend_invite_accept,
                  :end_of_hop,
                  :comment,
                  :like,
                  :ad_enable,
                  :message,
                  :new_hop,
                  :hop_about_to_end
  before_create :init_settings

  private

  def init_settings
    self.friend_invite = true
    self.friend_invite_accept = true
    self.end_of_hop = true
    self.comment = true
    self.like = true
    self.ad_enable = true
    self.message = true
    self.new_hop = true
    self.hop_about_to_end = true
  end

end
