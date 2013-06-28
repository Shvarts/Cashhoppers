class HopTask < ActiveRecord::Base
  belongs_to :hop

  belongs_to :user
  attr_accessible :hop_task_price, :sponsor_id, :text_for_hop
end
