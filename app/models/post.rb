class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validates_presence_of :body
  
  scope :questions, -> { where question: true }
  scope :art, -> { where art: true }
  
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
  
  private
  
  def text_or_image?
    if body.empty? and !image.url
      errors.add(:post, "cannot be empty.")
    end
  end
end
