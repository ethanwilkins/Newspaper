class Tournament < ActiveRecord::Base
	has_many :sports_matches
	has_many :members
	has_many :stats
  belongs_to :tab
	
	mount_uploader :image, ImageUploader
end
