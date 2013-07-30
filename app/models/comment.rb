class Comment < ActiveRecord::Base
  belongs_to :user
  has_one :notification
  attr_accessible :commentable_id, :text, :user_id
  validates :text, presence: true, length: {maximum: 140}
end
