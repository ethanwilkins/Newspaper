class User < ActiveRecord::Base
  has_many :loading_gifs
  has_many :translations
  has_many :game_boards
  has_many :activities
  has_many :feedbacks
  has_many :comments
  has_many :articles
  has_many :features
  has_many :prizes
  has_many :events
  has_many :cards
  has_many :posts
  has_many :notes
  has_many :polls
  has_many :tips
  
  belongs_to :group
  
  # validations for creation of user
  validates :name, presence: true
  validates :password, presence: true
  validates_confirmation_of :password
  validates_uniqueness_of :name
  validate :numeric_zip_if_present
  validate :only_one_global
  
  before_create :encrypt_password, :generate_token
  before_save :current_location, :downcase_fields
  
  mount_uploader :icon, ImageUploader
  
  geocoded_by :zip_code, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode, if: :zip_present?
  
  def close_enough(content)
    _close_enough = false
    # content always close enough when inside current users zip code or cherry picked tab
    if (content.zip_code and self.zip_code and content.zip_code == self.zip_code) or (content.is_a? Tab and \
      content.features.where(user_id: self.id).where(action: :cherry_pick).present?) or self.global
      _close_enough = true
    # close enough when within the users specified network size
    elsif content.latitude and self.latitude and self.network_size and \
      GeoDistance.distance(content.latitude, content.longitude, self.latitude,
      self.longitude).miles.number < self.network_size
      return true
    else
      _close_enough = true
    end
    return _close_enough
  end
  
  def notify(sender, action, item_id=1)
    Note.notify sender, self, action, item_id
  end
  
  def notify_mentioned(item)
    text = item.body
    for word in text.split(' ')
      if word.include? "@" and User.find_by_name(word.slice(word.index("@")+1..word.size))
        Note.notify(self, User.find_by_name(word.slice(word.index("@")+1..word.size)),
          :mention, item.id)
      end
    end
  end
  
  def images
    imgs = []
    for post in posts
      if post.image.url.present?
        imgs << post
      elsif post.pictures.present?
        for picture in post.pictures
          imgs << picture
        end
      end
    end
    return imgs
  end
  
  def last_visit
    if self.activities.present?
      return self.activities.last.created_at
    else
      return self.created_at
    end
  end
  
  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists? auth_token: self.auth_token
  end
  
  def update_token
    self.generate_token
    self.save
  end

  def self.authenticate(name, password)
    user = find_by_name(name.downcase)
    user = find_by_email(name.downcase) unless user
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def self.global
  	self.find_by_global true
  end
  
	# no longer needed  
#  def self.encrypt_all_passwords
#    for user in self.all
#      unless user.password_salt
#        user.encrypt_password
#        user.save
#      end
#    end
#  end
  
  private
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
  def current_location
    unless zip_code
      geoip = GeoIP.new('GeoLiteCity.dat').city(self.ip)
      if defined? geoip and geoip
        self.latitude = geoip.latitude
        self.longitude = geoip.longitude
        if latitude and longitude
          geocoder = Geocoder.search("#{latitude}, #{longitude}").first
          if geocoder and geocoder.formatted_address
            self.address = geocoder.formatted_address
          end
        end
      end
      get_zip
    end
  end

  def get_zip
    if self.address.present?
      place = self.address.split(", ")[2] if self.address.split(", ")[2].present?
      zip = place.split(" ")[1] if place and place.split(" ")[1].present?
      self.zip_code = place.split(" ")[1].to_i if zip and zip.size == 5
    end
    if self.zip_code
      Zip.record(self.zip_code)
    end
  end
  
  def zip_present?
		self.zip_code.present?
  end
  
  def to_param
    name
  end
  
  def downcase_fields
    email.downcase! if email
    name.downcase!
  end
  
  def only_one_global # non admin account for posting global content
  	if self.global and (User.exists? global: true or self.admin or self.master)
  		errors.add(:only_one_global, "There can only be one global account.")
  	end
  end
  
  def numeric_zip_if_present
    if zip_code.present? and (not zip_code.is_a? Integer or zip_code.to_s.size != 5)
      errors.add(:non_numeric_zip, "The zip code must be valid.")
    end
  end
end
