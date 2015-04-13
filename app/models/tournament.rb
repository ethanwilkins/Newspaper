class Tournament < ActiveRecord::Base
	has_many :sports_matches
	has_many :members
	has_many :stats
  belongs_to :tab
	
	mount_uploader :image, ImageUploader
  
  def teams
    _teams = []
    for member in self.members
      team = SportsTeam.find_by_id(member.sports_team_id)
      _teams << team if team
    end
    return _teams
  end
  
  def matches
    self.sports_matches
  end
end
