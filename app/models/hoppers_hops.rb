class HoppersHops < ActiveRecord::Base
  belongs_to :hop
  belongs_to :user

  attr_accessible :pts, :ask_password
end