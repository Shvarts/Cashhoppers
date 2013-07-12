class Message < ActiveRecord::Base
  attr_accessible :author_id, :receiver_id, :text, :email, :template, :email_text, :email_author, :subject, :file
  has_attached_file :file,
                    :url  => "/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension",
                    :default_url => "/assets/no_ad_picture.jpg",
                    :path => ":rails_root/public/images/ad_pictures/file/:id/MESSAGE_PICTURE.:extension"

  validates_presence_of :receiver_id
  validates_presence_of :email_text, :email_author,:email_author, if: :email?

  def email?
    email.class == TrueClass
  end



end
