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
  
  # determines if content.zip_code is close
  # enough, based on user.network_size
  def close_enough(content)
    if content.zip_code and zip_code and network_size
      if (content.zip_code - zip_code).abs < network_size
        true
      else
        false
      end
    else
      true
    end
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
