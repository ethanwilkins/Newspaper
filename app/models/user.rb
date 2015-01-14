class User < ActiveRecord::Base
  has_many :translations
  has_many :game_boards
  has_many :activities
  has_many :comments
  has_many :articles
  has_many :features
  has_many :prizes
  has_many :events
  has_many :cards
  has_many :posts
  has_many :notes
  
  belongs_to :group
  
  # validations for creation of user
  validates :name, presence: true
  validates :password, presence: true
  validates_confirmation_of :password
  validates_uniqueness_of :name
  validate :numeric_zip_if_present
  before_create :generate_token
  before_save :downcase_fields
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  mount_uploader :icon, ImageUploader
  
  def close_enough(content)
    _close_enough = false
    # verifies existence of required attributes
    if content.latitude and self.latitude and content.zip_code and self.zip_code and self.network_size
      # content always close enough when inside current users zip code or cherry picked tab
      if content.zip_code == self.zip_code or (content.is_a? Tab and \
        content.features.where(user_id: self.id).where(action: :cherry_pick).present?)
        _close_enough = true
      # verifies that content is within the users specified network size
      elsif GeoDistance.distance(content.latitude, content.longitude,
        self.latitude, self.longitude).miles.number < self.network_size
        case content.class
        when Post
          near_content = Post.where(zip_code: content.zip_code).size
          _close_enough = true if near_content < Random.rand(0..Post.all.size)
        when Tab
          near_content = Tab.where(zip_code: content.zip_code).size
          _close_enough = true if near_content < Random.rand(0..Tab.all.size)
        end
      end
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
    posts.where.not image: [nil, ""]
  end

  def self.authenticate(name, password)
    user = find_by_name(name.downcase)
    user = find_by_email(name.downcase) unless user
    if user && password == user.password
      user
    else
      nil
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
  
  def last_visit
    if self.activities.present?
      return self.activities.last.created_at
    else
      return self.created_at
    end
  end
  
  private
  
  def to_param
    name
  end
  
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
