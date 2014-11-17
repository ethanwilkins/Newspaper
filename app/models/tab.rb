class Tab < ActiveRecord::Base
  has_many :posts
  has_many :subtabs, dependent: :destroy
  has_many :features, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
  
  def self.most_popular
    self.all.sort_by(&:popularity).last 2
  end
  
  def popular_subtabs
    self.subtabs.sort_by(&:popularity).last 2
  end
  
  def popularity
    posts.size
  end
end
