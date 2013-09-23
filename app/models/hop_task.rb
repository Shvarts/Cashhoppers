class HopTask < ActiveRecord::Base
  has_many :user_hop_tasks, dependent: :destroy
  belongs_to :hop
  belongs_to :sponsor, class_name: 'User', foreign_key: :sponsor_id




  attr_accessible :price, :amt_paid,:creator_id, :link, :bonus, :pts, :sponsor_id, :text, :hop_id, :logo, :logo_file_name


  has_attached_file :logo,
                    :url  => "/images/hop_task_logos/hop_tasks/:id/Task_LOGO.:extension",
                    :default_url => "/assets/no_hop_logo.png",
                    :path => ":rails_root/public/images/hop_task_logos/hop_tasks/:id/Task_LOGO.:extension"


  #validates :bonus, :pts, numericality: { only_integer: true }
  validates :text, length: { minimum: 5, maximum:140 }
  validates :sponsor_id,  :presence => true
  validate :only_one_task_for_daily_hop, :on =>:create
  validates :logo, format: { with: /.png|.gif|.jpg|.jpeg|.JPEG|.GIF|.PNG|.JPG/,
                             message: "only image (.jpg, .png, .gif)" }
  validates :link, format: { with: /^http:\/\/.*\..*|^https:\/\/.*\..* | ""/, message: "only 'http://'" },  if: :link?


  before_save :pts_default

  private
  def pts_default
     pts = 0 unless pts
  end

  def only_one_task_for_daily_hop
    if self.hop.daily && !self.hop.hop_tasks.blank?
      errors.add(:Daily_hop, "Can be only one task for daily_hop.")
    end
  end
  def link_blank?
    self.link.blank?
  end


end