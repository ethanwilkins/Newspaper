class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab
  belongs_to :subtab
  
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validate :text_or_image?, on: :create
  
  mount_uploader :image, ImageUploader
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
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
