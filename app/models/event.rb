class Event < ActiveRecord::Base
  scope :approved, -> { where approved: true }
	scope :pending, -> { where approved: nil }
  
  def self.remove_expired
    for event in Event.all
      if event.date > DateTime.now
        event.destroy
      end
    end
  end
end
