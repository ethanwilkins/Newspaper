class Member < ActiveRecord::Base
  belongs_to :folder
  belongs_to :group
  belongs_to :event
  belongs_to :subtab
  belongs_to :tab
  belongs_to :tournament
  belongs_to :sports_match
  
  validate :unique_team_in_tournament
  validate :unique_team_in_match
  
  private
  
  def unique_team_in_match
  	if self.sports_match_id and self.sports_team_id
  		match = SportsMatch.find_by_id(self.sports_match_id)
  		if match and match.members.exists? sports_team_id: self.sports_team_id
  			errors.add(:team_already_in_match, "Invalid input.")
  		end
  	end
  end
  
  def unique_team_in_tournament
  	if self.tournament_id and self.sports_team_id
  		tournament = Tournament.find_by_id(self.tournament_id)
  		if tournament and tournament.members.exists? sports_team_id: self.sports_team_id
  			errors.add(:team_already_in_tournament, "Invalid input.")
  		end
  	end
  end
end
