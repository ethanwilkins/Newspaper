class Stat < ActiveRecord::Base
	belongs_to :sports_team
	belongs_to :sports_match
	belongs_to :tournament
	
	mount_uploader :image, ImageUploader
	
	def points_awarded
		if self.win
			3
		elsif self.loss
			0
		elsif self.tie
			1
		end
	end
end
