class User < ActiveRecord::Base
  has_many :game_boards
  has_many :activities
  has_many :comments
  has_many :articles
  has_many :prizes
  has_many :cards
  has_many :posts
  has_many :notes
  # validations for creation of user
  validates :name, presence: true
  validates :password, presence: true
  validates_confirmation_of :password
  validates_numericality_of :zip_code
  validates_uniqueness_of :name

  before_save :downcase_fields
  
  mount_uploader :icon, ImageUploader
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  def close_enough(content)
    _close_enough = false
    if content.latitude and self.latitude
      if GeoDistance.distance(content.latitude, content.longitude,
        self.latitude, self.longitude).miles < self.network_size
        _close_enough = true
      end
    else
      _close_enough = true
    end
    return _close_enough
  end

  def self.authenticate(name, password)
    user = find_by_name(name.downcase)
    if user && password == user.password
      user
    else
      nil
    end
  end
  
  private
  
  def downcase_fields
    email.downcase! if email
    name.downcase!
  end
end
