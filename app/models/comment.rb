class Comment < ActiveRecord::Base
  belongs_to :user
  attr_accessible :commentable_id, :text, :user_id
  validates :text, presence: true
end
