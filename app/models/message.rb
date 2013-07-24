class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  attr_accessible :sender_id, :receiver_id, :text, :email, :template, :email_author, :subject, :file , :send_at
  has_attached_file :file,
                    :url  => "/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension",
                    :default_url => "/images/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension"

  validates_presence_of :receiver_id , :text, :sender_id
  validates_presence_of :email_author, if: :email?

  def email?
    email.class == TrueClass
  end

  def self.create_arr_receivers(messages)
    arr = messages
    arr = messages.split(',')   unless messages.class == Array
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

      UserMailer.send_email_for_select_user(@message.id).deliver if email_state
      n= n + 1


     end
    end
    n
  end

  def self.create_hoppers_id_arr(params)
    if params
      hop = Hop.find_by_id(params)
      if !hop.hoppers.blank?
        @users = hop.hoppers.select(:id).all
        arr_id=[]
        for i in @users do
          arr_id << i.id
        end
       end
    end
    arr_id
  end


  def self.create_user_id_arr_by_zip(params)

    if params
      @users = User.where(:zip => params).select(:id).all
      arr_id=[]
      for i in @users do
        arr_id << i.id
      end
    end
   arr_id
  end



  def self.create_users_id_list(params,flash)
    select_id = []
    if !params.blank?
      select_id << params
      select_id << flash
      select_id.flatten!
      select_id.compact!
      select_id.uniq!
     end
    select_id
  end

  def self.conditions_for_users(params)
    conditions = []
    conditions = ["first_name LIKE ? OR last_name LIKE ?", "%#{params}%", "%#{params}%"]
    conditions = ["id LIKE ? OR last_name LIKE ?", "%#{params}%", "%#{params}%"]
    conditions
  end

  def self.complit_params(user,current_user,params)

    message = {}
    message[:receiver_id] = user.id

    message[:sender_id]= current_user.id
    message[:text]= params[:message][:text]
    message
  end
end
