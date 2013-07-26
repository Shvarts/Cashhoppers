class Prize < ActiveRecord::Base
  belongs_to :user
  belongs_to :hop
  attr_accessible :hop_name, :jackpot, :place
end
