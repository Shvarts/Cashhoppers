class Message < ActiveRecord::Base

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  attr_accessible :receiver_id, :sender_id, :schedule_date, :synchronized, :text

  validates :text, presence: true

  def self.conditions_for_users(params)
    ["id LIKE ? OR last_name LIKE ?", "%#{params}%", "%#{params}%"]
  end

end

#
#
#
#
#def email?
#  email.class == TrueClass
#end
#
#
#
#
#def self.send_emails_to(message, user_id, receivers_id, email_state)
#
#  n = 0
#
#  for i in receivers_id
#    message[:receiver_id] = i
#    message[:sender_id]=user_id
#    message[:email]= email_state
#    @message = Message.new(message)
#    if @message.save
#
#      UserMailer.send_email_for_select_user(@message.id).deliver if email_state
#      n= n + 1
#    end
#  end
#  n
#end
#
#def self.users_from_hop( params)
#  users_id = []
#  for i in params
#    hop = Hop.find_by_id(i)
#    users = hop.hoppers
#    for u in users
#      users_id << u.id
#    end
#  end
#  users_id
#end
#
#
#def self.users_from_zip(params)
#
#  users_id = []
#  for i in params
#    users = User.where(:zip => i)
#    for u in users
#      users_id << u.id
#    end
#
#  end
#  users_id
#end
#
#def self.conditions_for_users(params)
#  conditions = []
#  conditions = ["id LIKE ? OR last_name LIKE ?", "%#{params}%", "%#{params}%"]
#  conditions
#end
#
#def self.external_id(params)
#  (params.class == Array)? (arr_id = params) : (arr_id = %W{ #{params.to_i} })
#  arr = arr_id.repeated_permutation(1).to_a
#  return arr, arr_id
#
#end

