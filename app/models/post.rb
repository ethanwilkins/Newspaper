class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab
  belongs_to :subtab
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
end
