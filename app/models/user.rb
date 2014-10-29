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
  
  def close_enough(content)
    _close_enough = false
    
    zips_in_range = []
    for zip in Zip.all
      # verifies values and gets zips within constant range
      if self.zip_code and self.network_size and content.zip_code
        difference = (self.zip_code - zip.zip_code).abs
        if difference < Zip.zip_code_range
          zips_in_range << zip
        end
      end
    end
    
    # sorts by difference
    zips_in_range.sort_by! do |zip|
      (self.zip_code - zip.zip_code).abs
    end
    
    total_density = 0
    for zip in zips_in_range
      # adds the density of the closest zips until network size is reached
      combined_density = zip.density + Zip.find_by_zip_code(self.zip_code).density
      if combined_density + total_density < self.network_size and not _close_enough
        total_density += combined_density
        if zip.zip_code == content.zip_code
          _close_enough = true
        end
      else
        break
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
