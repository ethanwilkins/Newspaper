class Event < ActiveRecord::Base
	def self.pending
		where approved: nil
	end
end
