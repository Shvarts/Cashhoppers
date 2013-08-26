class UserSettings < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  attr_accessible :friend_invite,
                  :ad_enable,
                  :message,
                  :new_hop,
                  :hop_about_to_end,
                  :comment_or_like,
                  :user_id
  before_create :init_settings

  private

  def init_settings
    self.ad_enable = true

    self.friend_invite = true
    self.message = true
    self.new_hop = true
    self.hop_about_to_end = true
    self.comment_or_like = true
  end

end
