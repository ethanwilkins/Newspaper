module SportsMatchesHelper
	def sports_listing_info(item)
		info = ": "
		item.teams.each { |team| info << team.name + ", " }
		info << item.date.to_s + ", " if item.date
		info << item.location if item.location
		return info
	end
end
