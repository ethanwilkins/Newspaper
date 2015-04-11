class Stat < ActiveRecord::Base
	belongs_to :sports_team
	belongs_to :sports_match
	belongs_to :tournament
end
