class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :tab
  
  has_many :members
  has_many :stats, dependent: :destroy
	
	mount_uploader :image, ImageUploader
  
  def scores # live scores, not necessarily final
    stat = self.stats.where.not(first_teams_score: nil).
      where.not(second_teams_score: nil).last
    if stat.first_teams_score and stat.second_teams_score
      return "(#{stat.first_teams_score} - #{stat.second_teams_score})"
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
    self.stats.where(tie: true).present?
  end
	
	def finished?
    self.stats.where(finished: true).present?
	end
  
  def teams
    _teams = []
    for member in self.members
      team = SportsTeam.find_by_id(member.sports_team_id)
      _teams << team if team
    end
    return _teams
  end
end
