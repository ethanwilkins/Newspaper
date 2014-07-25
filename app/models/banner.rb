class Banner < ActiveRecord::Base
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  def self.active
    begin
      find(:first, :conditions => ["active = ?", true]).first
    rescue
      nil
    end
  end
end
