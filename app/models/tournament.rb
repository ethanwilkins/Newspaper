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
    teams_size = teams.size # to be later validated
    pairs = (teams.size/2).times.map do
    	[teams.shift, teams.pop]
    end
    # sets number of rounds
		self.update total_rounds: (self.teams.size / 2.to_f).ceil.to_i
    
    # inserts teams into matches
    for pair in pairs
      break if self.matches.size.eql? self.teams.size - 1 # ensures correct num of matches
  		match = self.matches.create round: self.get_round pairs.index(pair)
  		match.members.create sports_team_id: pair.first.id
  		match.members.create sports_team_id: pair.last.id
  	end
    # inserts more if any missing
    if teams.present?
      match = self.matches.create round: self.total_rounds
      match.members.create sports_team_id: teams.last.id
    elsif teams_size.even?
      ((teams_size - 1) - self.matches.size).times do
        self.matches.create round: self.total_rounds
      end
    end
	end
	
	# gets correct round for each match
	# factors: team size, match size, total_rounds, index
	def get_round index
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
