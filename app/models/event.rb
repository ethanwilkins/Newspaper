class Event < ActiveRecord::Base
  belongs_to :tab
  belongs_to :user
  
  has_many :translations, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :members, dependent: :destroy
  
  scope :approved, -> { where(approved: true).where(tab_id: nil).where(subtab_id: nil) }
	scope :pending, -> { where(approved: nil).where(tab_id: nil).where(subtab_id: nil) }

  mount_uploader :image, ImageUploader
  
  def going
    members.where status: :going
  end
  
  def not_going
    members.where status: :not_going
  end
  
  def invited?(user)
    members.where(status: :invited).
      exists? user_id: user.id
  end
  
  def invite_users(user_names)
    if tab
      for user_name in user_names.split(", ")
        invited_user = User.find_by_name(user_name.downcase)
        if invited_user
          members.create(user_id: invited_user.id, event_id: id, status: :invited)
          Note.notify(user, invited_user, :event_invitation, id)
        end
      end
    end
  end
  
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
