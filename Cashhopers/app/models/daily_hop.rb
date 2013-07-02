class DailyHop < ActiveRecord::Base
  attr_accessible :jackpot, :name, :points, :share_point, :text_for_item, :users, :winner, :user_id
  has_one :hop
  belongs_to :user

end
