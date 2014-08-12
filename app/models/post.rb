class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  scope :jokes, -> { where joke: true }
  scope :questions, -> { where question: true }
  
  mount_uploader :image, ImageUploader
end
