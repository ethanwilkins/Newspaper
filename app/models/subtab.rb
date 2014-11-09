class Subtab < ActiveRecord::Base
  belongs_to :tab
  has_many :posts
  
  mount_uploader :icon, ImageUploader
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
  
  def popularity
    posts.size
  end
end
