class Event < ActiveRecord::Base
  def self.approved
    where approved: true
  end
  
	def self.pending
		where approved: nil
	end
end
