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
    # to be later validated
    teams_size = teams.size
    # creates pairs, best with worst, as list shortens
    team_pairs = build_pairs self.teams, :points
		# correctly inserts teams based mainly on team size
    build_initial_matches teams, teams_size, team_pairs
    build_parent_matches; build_qualifying_matches
	end
  
	def build_initial_matches teams, teams_size, team_pairs
    initial_matches_size = ideal_bracket_size / 2
    for pair in team_pairs
			break if self.matches.size.eql? initial_matches_size
			match = self.matches.create!
			match.members.create sports_team_id: pair.first.id
			match.members.create sports_team_id: pair.last.id
		end
	end
  
  def build_parent_matches
    # builds second level of hierarchy
    match_pairs = build_pairs matches
    for pair in match_pairs
      match = self.matches.create!
      pair.first.update sports_match_id: match.id
      pair.last.update sports_match_id: match.id
    end
    # builds on top until root is met
    loop do
      parent_pairs = build_pairs parent_matches
      break if parent_pairs.empty?
      for pair in parent_pairs
        match = self.matches.create!
        pair.first.update sports_match_id: match.id
        pair.last.update sports_match_id: match.id
      end
    end
  end
  
  def build_qualifying_matches
    for match in first_round_matches
      break if extra_teams.size.zero?
      qualifier = match.children.create
      extra_teams.last.update sports_match_id: qualifier.id
      match.teams.last.update sports_match_id: qualifier.id
    end
  end
	
	def ideal_bracket_size
    infinity = 1.0 / 0.0
    if self.qualifying
      case self.teams.size
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
      case self.teams.size
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
  
  # for qualifying rounds
  def extra_teams
    extras = []
    for team in teams
      left_out = true
      for match in matches
        if match.teams.include? team
          left_out = false
        end
      end
      extras << team if left_out
    end
    return extras
  end
  
  def matches
    self.sports_matches
  end
  
  # matches that have children but
  # don't have parents yet
  def parent_matches
    parents = []
    for match in matches
      if match.children.present? and not match.parent
        parents << match
      end
    end
    return parents
  end
  
  def first_round_matches
    first_round = []
    for match in matches
      if match.children.empty?
        first_round << match
      end
    end
    return first_round
  end
  
  def build_pairs list, sort_method=nil
    list = list.sort_by do |i|
      if sort_method and i.respond_to? sort_method
        i.send sort_method.to_sym
      else
        i
      end
    end
    pairs = (list.size/2).times.map do
    	[list.shift, list.pop]
    end
    return pairs
  end
end
