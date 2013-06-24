class Admin::Application < ActiveRecord::Base
  attr_accessible :api_key, :description, :name
  validates :name, :presence => true
end
