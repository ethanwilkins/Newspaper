class SportsTeam < ActiveRecord::Base
	belongs_to :member
	has_many :stats
	
	mount_uploader :image, ImageUploader
end
