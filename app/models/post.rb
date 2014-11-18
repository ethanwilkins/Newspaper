class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab
  belongs_to :subtab
  
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validate :text_or_image?, on: :create
  
  mount_uploader :image, ImageUploader
  
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  def self.delete_expired
    for post in self.all
      if post.expiration_date and post.expiration_date == Date.current
        post.destroy
      end
    end
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
