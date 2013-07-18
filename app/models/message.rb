class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  attr_accessible :sender_id, :receiver_id, :text, :email, :template, :email_author, :subject, :file , :send_at
  has_attached_file :file,
                    :url  => "/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension",
                    :default_url => "/images/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension"

  validates_presence_of :receiver_id , :text, :sender
  validates_presence_of :email_author, if: :email?

  def email?
    email.class == TrueClass
  end

  def self.create_arr_receivers(messages)
    arr = messages.to_s.chars.to_a
    emails= []
    for i in arr
      emails << i if !(i.to_i == 0)
    end
    emails
  end

  def self.user_arr(arr)
    ids=Message.create_arr_receivers(arr)
    @users =[]
    for i in ids
      @users << User.find_by_id(i)
    end

    @users
  end

  def self.send_emails_to(message,user_id, email_state)
    emails = Message.create_arr_receivers(message[:receiver_id])
    n = 0
    for i in emails
      message[:receiver_id] = i
      message[:sender_id]=user_id
      message[:email]= email_state
    @message = Message.new(message)
    if @message.save
      if UserMailer.send_email_for_select_user(@message.id).deliver
        n= n + 1
      end
    end
    end
    n
  end



end
