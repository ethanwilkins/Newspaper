class Tournament < ActiveRecord::Base
	has_many :sports_matches
	has_many :sports_teams
end
