class Note < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  
  def self.checked
    where(checked: true)
  end
  
  def self.unchecked
    where(checked: false)
  end
  
  def self.notify(sender, receiver, action, item_id=1)
    if sender != receiver
      if sender
        name = sender.name.capitalize
      else
        sender = User.first
      end
      case action
        when :post_comment
          message = "#{name} commented on your post."
        when :article_comment
          message = "#{name} commented on your article."
        when :comment_reply
          message = "#{name} replied to your comment."
        when :like_post
          message = "#{name} liked your post."
        when :event_approved
          message = "Your event was approved."
        when :event_denied
          message = "Your event was denied."
        when :tab_approved
          message = "Your tab was approved."
        when :tab_denied
          message = "Your tab was denied."
        when :you_won
          message = "You won! Call 555-5454 now!"
      end
      receiver.notes.create!(message: message, sender_id: sender.id,
        action: action.to_s, item_id: item_id)
    end
  end
end
