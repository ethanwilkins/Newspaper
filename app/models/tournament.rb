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

# instead of finding total rounds, could go through list of pairs,
# creating initial matches and parent matches based on team_size,
# then accounting for qualifying or bye rounds afterwards if teams
# are left over from fitting teams into ideal bracket size

# the matches within each round do not have to be played
# in any particular order

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
		# correctly inserts teams based mainly on team size
    self.build_matches teams, teams_size, pairs
	end
  
	def build_initial_matches teams, teams_size, pairs
    initial_matches_size = ideal_bracket_size / 2
    for pair in pairs
			break if self.matches.size.eql? initial_matches_size
			match = self.matches.create!
			match.members.create sports_team_id: pair.first.id
			match.members.create sports_team_id: pair.last.id
		end
	end
  
  def build_parent_matches
    
  end
  
  def build_qualifying_matches
    
  end
	
	# matches missing
	def num_missing teams_size
		return (teams_size - 1) - self.matches.size
	end
	
	def ideal_bracket_size
    infinity = 1.0 / 0.0
    if self.qualifying
      case self.matches.size
      when 4..7
        return 4
      when 8..15
        return 8
      when 16..31
        return 16
      when 32..63
        return 32
      when 64..127
        return 64
      when 128..infinity
        return 128
      end
    else
      case self.matches.size
      when 3..4
        return 4
      when 5..8
        return 8
      when 9..16
        return 16
      when 17..32
        return 32
      when 33..64
        return 64
      when 65..128
        return 128
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
