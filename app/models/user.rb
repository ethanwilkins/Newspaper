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

  before_save :downcase_name
  
  mount_uploader :icon, ImageUploader
  
  ZIP_CODE_RANGE = 10
  
  def close_enough(content)
    _close_enough = false
    zips_in_range = []
    for zip in Zip.all
      difference = (self.zip_code - zip.zip_code).abs
      if self.zip_code and self.network_size and content.zip_code
        if difference < ZIP_CODE_RANGE + self.network_size
          zips_in_range << zip.zip_code
        end
      end
    end
    
    # sorts by difference
    zips_in_range.sort_by! do |zip|
      (self.zip_code - zip).abs
    end
    
    # removes the most different and searches for match
    zips_to_drop = zips_in_range.size / 5 # the number to drop
    for zip in zips_in_range.reverse.drop zips_to_drop
      if content.zip_code == zip
        _close_enough = true
      end
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
  
  def downcase_name
    name.downcase!
  end
end
