class EmailAlert < ActiveRecord::Base
  attr_accessible :receiver_id, :schedule_date, :sender_id, :subject, :template_id, :text
end
