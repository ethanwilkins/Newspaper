class Event < ActiveRecord::Base
  scope :approved, -> { where approved: true }
	scope :pending, -> { where approved: nil }
  
  has_many :translations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy

  mount_uploader :image, ImageUploader
  
  def self.remove_expired(events)
    for event in events
      if event.date < DateTime.now
        event.destroy
      end
    end
  end
end
