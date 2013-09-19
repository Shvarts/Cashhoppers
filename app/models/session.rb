class Session < ActiveRecord::Base
  belongs_to :user
  attr_accessible :auth_token, :device, :device_token, :user_id, :updated_at, :api_kay
end
