class Event < ActiveRecord::Base
  scope :approved, -> { where approved: true }
	scope :pending, -> { where approved: nil }
  
  def self.remove_expired(events)
    for event in events
      if event.date < DateTime.now
        event.destroy
      end
    end
  end
end
