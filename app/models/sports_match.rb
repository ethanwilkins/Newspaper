class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :tab
  has_many :stats
  has_many :members
	
	mount_uploader :image, ImageUploader
end
