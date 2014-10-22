class User < ActiveRecord::Base
  has_many :game_boards
  has_many :comments
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
  
  # determines if content.zip_code is close
  # enough, based on user.network_size
  def close_enough(content)
    zips_in_range = 0
    for user in User.all
      if self.zip_code and self.network_size
        if (self.zip_code - user.zip_code).abs < ZIP_CODE_RANGE
          zips_in_range += 1
        end
      end
    end
    return true # for now
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
