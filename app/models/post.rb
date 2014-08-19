class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  scope :questions, -> { where question: true }
  
  mount_uploader :image, ImageUploader
  
  def self.jokes
    where(joke: true).sort_by(&:score)
  end
  
  def score
    Vote.score(self)
  end
  
  def up_votes
    votes.where up: true
  end
end
