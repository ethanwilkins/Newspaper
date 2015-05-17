class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :sports_match
  belongs_to :tab
  
  has_many :members
  has_many :sports_matches
  has_many :stats, dependent: :destroy
  
  validate :valid_if_non_tournament
  
	mount_uploader :icon, ImageUploader
  
  def scores # live scores, not necessarily final
    stat = self.stats.where.not(first_teams_score: nil).
      where.not(second_teams_score: nil).last
    if stat and stat.first_teams_score and stat.second_teams_score
      return "(#{stat.first_teams_score} - #{stat.second_teams_score})"
    else
      return nil
    end
  end
  
  def victor
    if self.finished? and not self.tied?
      return SportsTeam.find_by_id(self.stats.where.
        not(winning_team_id: nil).last.winning_team_id)
    else
      return nil
    end
  end
  
  def tied?
  	self.stats.where(finished: true).
  		where(winning_score: nil).
  		where(losing_score: nil).
  		present?
  end
	
	def finished?
    self.stats.where(finished: true).present?
	end
	
	def parent
		self.sports_match
	end
	
	def children
		self.sports_matches
	end
  
  def teams
    _teams = []
    for member in self.members
      team = SportsTeam.find_by_id(member.sports_team_id)
      _teams << team if team
    end
    return _teams
  end
  
  private
  
  def valid_if_non_tournament
    if self.tournament_id.nil? and (self.date.nil? or self.location.nil?)
      errors.add(:date_and_location_required, "Date and location are required.")
    end
  end
end
