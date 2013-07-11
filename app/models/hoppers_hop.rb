class HoppersHop < ActiveRecord::Base
  belongs_to :user
  belongs_to :hop
   attr_accessible :user_id, :hop_id
end
