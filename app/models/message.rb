class Message < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :folder
  belongs_to :user
  
  scope :unread, -> { where seen: [nil, false] }
  
  mount_uploader :image, ImageUploader
end
