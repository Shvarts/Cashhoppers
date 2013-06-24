class Role < ActiveRecord::Base
  has_many :users_roles
  has_and_belongs_to_many :users
  attr_accessible :name
end
