class Session < ActiveRecord::Base
  attr_accessible :auth_token, :user_id, :updated_at
end
