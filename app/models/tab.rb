class Tab < ActiveRecord::Base
  has_many :posts
  mount_uploader :icon, ImageUploader
end
