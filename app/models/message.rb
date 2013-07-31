class Message < ActiveRecord::Base

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :receiver_id, :sender_id, :schedule_date, :synchronized, :text

  validates :text, presence: true

end