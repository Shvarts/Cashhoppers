class EmailAlert < ActiveRecord::Base

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :receiver_id, :schedule_date, :sender_id, :subject, :template_id, :text

  validates :text, presence: true
  validates :subject, presence: true
  validates :template_id, presence: true
end
