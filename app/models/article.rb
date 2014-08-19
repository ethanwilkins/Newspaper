class Article < ActiveRecord::Base
  has_many :comments
  
  mount_uploader :image, ImageUploader
  
  def self.ads
    where ad: true
  end
end
