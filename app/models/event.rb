class Event < ActiveRecord::Base
  belongs_to :tab
  belongs_to :user
  
  has_many :translations, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  
  scope :approved, -> { where(approved: true).where tab_id: nil }
	scope :pending, -> { where(approved: nil).where tab_id: nil }

  mount_uploader :image, ImageUploader
  
  def score
    comments.size
  end
  
  def self.remove_expired(events)
    for event in events
      if event.date < DateTime.now
        event.destroy
      end
    end
  end
end
