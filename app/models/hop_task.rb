class HopTask < ActiveRecord::Base
  has_many :user_hop_tasks, dependent: :destroy
  belongs_to :hop
  belongs_to :sponsor, class_name: 'User', foreign_key: :sponsor_id


  attr_accessible :price, :amt_paid,:creator_id, :bonus, :pts, :sponsor_id, :text, :hop_id, :logo, :logo_file_name


  has_attached_file :logo,
                    :url  => "/images/hop_task_logos/hop_tasks/:id/Task_LOGO.:extension",
                    :default_url => "/assets/no_hop_logo.png",
                    :path => ":rails_root/public/images/hop_task_logos/hop_tasks/:id/Task_LOGO.:extension"


  #validates :bonus, :pts, numericality: { only_integer: true }
  validates :text, length: { minimum: 5, maximum:140 }
  validates :sponsor_id,  :presence => true
  validate :only_one_task_for_daily_hop

  private

  def only_one_task_for_daily_hop
    if self.hop.daily && !self.hop.hop_tasks.blank?
      errors.add(:id, "Can be only one task for daily_hop.")
    end
  end

end