module SportsMatchesHelper
	def match_listing_info(match)
		info = ": "
		match.teams.each { |team| info << team.name + ", " }
    info << match.scores + ", " if match.scores
		info << match.date.to_s + ", " if match.date
		info << match.location if match.location
		return info
	end
end
