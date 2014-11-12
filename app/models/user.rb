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
  validates_uniqueness_of :name
  
  validate :numeric_zip_if_present
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode

  before_save :downcase_fields
  
  mount_uploader :icon, ImageUploader
  
  # show everything in user locale
  def close_enough(content)
    _close_enough = false
    if content.latitude and self.latitude and content.zip_code and self.zip_code and self.network_size
      if GeoDistance.distance(content.latitude, content.longitude, self.latitude, self.longitude).miles.number < self.network_size
        if content.is_a? Post and content.zip_code != self.zip_code
          local_posts = Post.where(zip_code: content.zip_code).size
          _close_enough = true if local_posts < Random.rand(1..Post.all.size)
        else
          _close_enough = true
        end
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
  
  def numeric_zip_if_present
    if self.zip_code.present? and self.zip_code == 0
      errors.add(:non_numeric_zip, "The zip code must be valid.")
    end
  end
end
