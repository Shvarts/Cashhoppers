class Prize < ActiveRecord::Base
  attr_accessible :cost, :place, :user_id, :hop_id
  belongs_to :hop
  belongs_to :user
end
