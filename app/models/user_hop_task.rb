class UserHopTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :hop_task
  # attr_accessible :title, :body
end
