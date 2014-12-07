class Message < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :folder
  belongs_to :user
  
  mount_uploader :image, ImageUploader
end
