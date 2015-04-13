class SportsTeam < ActiveRecord::Base
	belongs_to :member
	has_many :stats
	
	mount_uploader :image, ImageUploader
  
  def wins
    self.stats.where(win: true).size
  end
  
  def losses
    self.stats.where(loss: true).size
  end
end
