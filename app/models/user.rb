class User < ActiveRecord::Base
  has_many :users_roles
  has_and_belongs_to_many :roles
  has_many :services, :dependent => :destroy

  before_create :create_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :last_name, :first_name, 
         :user_name, :password_confirmation, :remember_me, :zip,:avatar

  has_attached_file :avatar, # ,:styles => { :original => "400x400>" },
                    :url  => "/images/avatars/users/:basename.:extension",
                    :default_url => "/assets/noavatar.gif",
                    :path => ":rails_root/public/images/avatars/users/:basename.:extension"


 validates :email, :password, :presence => true   # zip by default
#validates :zip, numericality: {only_integer: true}
  

  
  # attr_accessible :title, :body

  def role?(role)
    !!self.roles.find_by_name(role.to_s.camelize)
  end

  private

  def create_role
    self.roles << Role.find_by_name(:user)
  end

end
