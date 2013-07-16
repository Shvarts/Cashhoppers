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

  #def email?
  #  email.class == TrueClass
  #end



end
