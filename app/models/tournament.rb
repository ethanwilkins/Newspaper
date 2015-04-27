class Tournament < ActiveRecord::Base
	has_many :sports_matches
	has_many :members
  has_many :prizes
	has_many :stats
  
  belongs_to :tab
	
	mount_uploader :icon, ImageUploader
	
	def assemble params
    # creates teams
  	params.each do |key, value|
  		if key.include? "team_"
  			self.members.create(sports_team_id: value)
  		end
  	end
  	
    # creates team pairs, best with worst
    teams = self.teams.sort_by { |team| team.points }
    pairs = (teams.size/2).times.map do
    	[teams.shift, teams.pop]
    end
    
    # sets number of rounds
		self.update total_rounds: (self.teams.size / 2.to_f).ceil.to_i
    
    # inserts team pairs into matches
    for pair in pairs
      break if self.matches.size.eql? self.teams.size - 1 # ensures correct num of matches
  		match = self.matches.create round: self.total_rounds - (pairs.index(pair) + 1)
  		match.members.create sports_team_id: pair.first.id
  		match.members.create sports_team_id: pair.last.id
  	end
	end
  
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
