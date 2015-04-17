class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :tab
  
  has_many :members, dependent: :destroy
  has_many :stats, dependent: :destroy
	
	mount_uploader :image, ImageUploader
	
	def finished
		_finished = false
		for stat in self.stats
			if stat.finished
				_finished = true
			end
		end
		return _finished
	end
  
  def teams
    _teams = []
    for member in self.members
      team = SportsTeam.find_by_id(member.sports_team_id)
      _teams << team if team
    end
    return _teams
  end
end
