class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :tab
  
  has_many :members
  has_many :stats
	
	mount_uploader :image, ImageUploader
  
  def teams
    _teams = []
    for member in self.members
      team = SportsTeam.find_by_id(member.sports_team_id)
      _teams << team if team
    end
    return _teams
  end
end
