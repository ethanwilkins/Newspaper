class Event < ActiveRecord::Base
  scope :approved, -> { where approved: true }
	scope :pending, -> { where approved: nil }

  mount_uploader :image, ImageUploader
  
  def self.remove_expired(events)
    for event in events
      if event.date < DateTime.now
        event.destroy
      end
    end
  end
end
