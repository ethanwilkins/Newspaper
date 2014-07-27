class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  
  mount_uploader :image, ImageUploader
end
