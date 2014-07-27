class Article < ActiveRecord::Base
  has_many :comments
  
  mount_uploader :image, ImageUploader
end
