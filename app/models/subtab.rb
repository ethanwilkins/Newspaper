class Subtab < ActiveRecord::Base
  belongs_to :tab
  has_many :posts
  
  mount_uploader :icon, ImageUploader
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
end
