# qualifying matches will always consist of lowest ranked teams
# user chooses qualifying or by rounds at creation
# by round gives a freebe match to the best team
# freebe match does not give points, just next round
# by rounds by default, number of by rounds can vary
# ideal brackets: 4, 8, 16, 32, 64, 128

# winning teams pushed into correct match in
# next round based off of parent/child hierarchy
# hierarchy defined at creation, teams just move up as they win

# (team_size - ideal_bracket_size) + 1 = qualifying_team_pool_size

class Tournament < ActiveRecord::Base
	has_many :sports_matches, dependent: :destroy
	has_many :members
  has_many :prizes
	has_many :stats
  
  belongs_to :tab
	
	mount_uploader :icon, ImageUploader
	
	def assemble params
    # creates team objects
  	params.each do |key, value|
  		if key.include? "team_"
  			self.members.create(sports_team_id: value)
  		end
  	end
    # creates pairs, best with worst, as list shortens
    teams = self.teams.sort_by { |team| team.points }
    teams_size = teams.size # to be later validated
    pairs = (teams.size/2).times.map do
    	[teams.shift, teams.pop]
    end
    # sets correct number of total rounds for the tournament
		self.update total_rounds: (self.teams.size / 2.to_f).ceil.to_i
		# correctly inserts teams based mainly on team size
    self.build_matches teams, teams_size, pairs
	end
  
	def build_matches teams, teams_size, pairs
	  # creates matches and inserts teams
    for pair in pairs
			break if self.matches.size.eql? self.teams.size - 1 # ensures correct num of matches
			match = self.matches.create round: self.get_round(pairs.index(pair) + 1)
			match.members.create sports_team_id: pair.first.id
			match.members.create sports_team_id: pair.last.id
		end
    # creates more matches if any missing
    if teams.present?
      match = self.matches.create round: self.total_rounds
      match.members.create sports_team_id: teams.last.id
      if self.num_missing(teams_size) > 0	
		    self.num_missing(teams_size).times do
		      self.matches.create round: teams_size / 2 # make shift round number
		    end
      end
    elsif teams_size.even?
      self.num_missing(teams_size).times do
        self.matches.create round: self.total_rounds
      end
    end
	end
	
	# matches missing
	def num_missing teams_size
		return (teams_size - 1) - self.matches.size
	end
	
	def get_ideal_bracket_size
		case self.teams.size
		when 3
			if self.qualifying
				2
			else
				4
			end
		end
	end
	
	# gets correct round for each match
	def get_round index
		case self.teams.size
		when 3
			if index < 2
				return 1
			else
				return 2
			end
		when 4
			if index < 3
				return 1
			else
				return 2
			end
		when 5
			if index < 3
				return 1
			elsif index < 4
				return 2
			else
				return 3
			end
		when 6
			if index < 3
				return 1
			elsif index < 5
				return 2
			else
				return 3
			end
		when 7
			if index < 3
				return 1
			elsif index < 5
				return 2
			elsif index < 6
				return 3
			else
				return 4
			end
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
