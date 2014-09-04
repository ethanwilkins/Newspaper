class Subtab < ActiveRecord::Base
  has_many :posts
  belongs_to :tab
  
  mount_uploader :icon, ImageUploader
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
end
