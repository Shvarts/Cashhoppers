class User < ActiveRecord::Base

  has_and_belongs_to_many :games, :join_table => "hoppers_hops" , :class_name=>"Hop"
  has_many :incoming_messages, :class_name =>  'Message' ,  :foreign_key => :sender_id, conditions: ['sended = 1']
  has_many :outcoming_messages, :class_name => 'Message' , :foreign_key => :receiver_id, conditions: ['sended = 1']
  has_many :hops,  foreign_key: "producer_id"
  has_many :user_hop_tasks
  has_many :sponsored_hop_tasks, class_name: 'HopTask'
  has_many :hop_tasks, :foreign_key => :sponsor_id
  has_many :users_roles
  has_and_belongs_to_many :roles
  has_many :services, :dependent => :destroy
  has_many :friendships
  has_many :friends,
           :through => :friendships,
           :conditions => "status = 'accepted'"
  has_many :requested_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'requested'"
  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'pending'"
  has_many :comments
  has_many :likes
  has_attached_file :avatar, :styles => { :original => "400x400>", :small => "50x50" },
                    :url  => "/images/avatars/users/:id/:style/USER_AVATAR.:extension",
                    :default_url => "/assets/no_avatar.png",
                    :path => ":rails_root/public/images/avatars/users/:id/:style/USER_AVATAR.:extension"
  has_many :notifications
  has_many :prizes, dependent: :delete_all

  has_one :user_settings

  before_create :before_create
  after_create :after_create
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  attr_accessible :email, :password, :last_name, :first_name, 
         :user_name, :password_confirmation, :remember_me, :zip, :avatar, :contact, :phone,
         :bio, :twitter, :facebook, :google, :avatar_file_name, :id

  validates :zip, :presence => true
  validates :zip, numericality: {only_integer: true, allow_blank: true}
  validates :avatar, format: { with: /.png|.gif|.jpg/,
                             message: "only image (.jpg, .png, .gif)" }


  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  def self.zip_codes
    ActiveRecord::Base.connection.select_all("SELECT DISTINCT users.zip FROM users;");
  end

  def self.admin?(user)
    user.role? :admin
  end

 def self.producer?(user)
   user.role? :producer
  end

  def self.sponsor?(user)
    user.role? :sponsor
  end

  def self.advertiser?(user)
    user.role? :advertiser
  end
  def self.user?(user)
    user.role? :user
  end
 def self.can_edit?(user,id)
   user.id == id || (user.role? :admin)
  end

  private

  def before_create
    frog_legs = 0
  end

  def after_create
    self.roles << Role.find_by_name(:user)
    user_settings = UserSettings.create(user_id: id)
  end

end
