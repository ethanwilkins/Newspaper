class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab
  belongs_to :subtab

  has_many :translations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  validate :text_or_image?, on: :create
  
  mount_uploader :image, ImageUploader
  
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  def self.repopulate
    for post in self.all
      if post.repopulation_interval and post.repopulation_interval != 0 and \
        post.repopulation_interval <= (post.created_at.to_date - Date.current).to_i.abs
        new_post = post.dup
        new_post.image = post.image
        if new_post.reincarnations.nil?
          new_post.reincarnations = 1
        elsif new_post.reincarnations >= 5
          new_post.repopulation_interval = 0
        else
          new_post.reincarnations = new_post.reincarnations + 1
        end
        if new_post.save
          post.destroy
        end
      end
    end
  end
  
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
    if (body.nil? or body.empty?) and !image.url
      errors.add(:post, "cannot be empty.")
    end
  end
end
