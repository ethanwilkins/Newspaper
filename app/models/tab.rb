class Tab < ActiveRecord::Base
  has_many :posts
  mount_uploader :icon, ImageUploader
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
end
