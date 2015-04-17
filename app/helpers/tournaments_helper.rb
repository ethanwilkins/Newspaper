module TournamentsHelper
	def tournament_listing_info(tournament)
		info = ": "
		tournament.teams.each { |team| info << team.name + ", " }
		info << tournament.date.to_s + ", " if tournament.date
		info << tournament.location if tournament.location
		return info
	end
end
