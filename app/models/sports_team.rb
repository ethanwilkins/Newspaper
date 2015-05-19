class SportsTeam < ActiveRecord::Base
	belongs_to :member
	has_many :stats
	
	validates_presence_of :name
	
	mount_uploader :icon, ImageUploader
  
  def rank
    
  end
	
	def wins
		wins = 0
		self.matches.each { |match| wins += 1 \
			if match.victor.eql? self and not match.exhibition }
		return wins
	end
	
	def losses
		losses = 0
		self.matches.each { |match| losses += 1 \
			if match.finished? and not match.tied? \
			and not match.victor.eql? self \
			and not match.exhibition }
		return losses
	end
	
	def points
		points = 0
		for match in self.matches
			unless match.exhibition
				if match.victor.eql? self
					points += 3
				elsif match.tied?
					points += 1
				end
			end
		end
		return points
	end
	
	def matches
		matches = []
		members = Member.where(sports_team_id: self.id).where.not(sports_match_id: nil)
		members.each { |member| matches << SportsMatch.find(member.sports_match_id) \
			if SportsMatch.find_by_id(member.sports_match_id) }
		return matches
	end
	
	def tournaments
		tournaments = []
		members = Member.where(sports_team_id: self.id).where.not(tournament_id: nil)
		members.each { |member| tournaments << Tournament.find(member.tournament_id) \
			if Tournament.find_by_id(member.tournament_id) }
		return tournaments
	end
end
