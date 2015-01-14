class Post < ActiveRecord::Base
  belongs_to :subtab
  belongs_to :user
  belongs_to :tab

  has_many :translations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :folders, dependent: :destroy
  has_many :votes, dependent: :destroy
  
  accepts_nested_attributes_for :pictures
  
  validate :text_or_image?, on: :create
  after_create :apply_expiration
  
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
      if post.expiration_date and (post.expiration_date == Date.current \
        or not post.expiration_date.future?)
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
  
  def apply_expiration
    if self.tab and self.tab.features.exists? "post_expiration"
      self.expiration_date = 10.days.since(Date.current).to_date
    end
  end
  
  def text_or_image?
    if (body.nil? or body.empty?) and (!image.url and photoset.nil?)
      errors.add(:post, "cannot be empty.")
    end
  end
end
