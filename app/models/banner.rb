class Banner < ActiveRecord::Base
  has_many :comments
  
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
end
