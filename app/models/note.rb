class Note < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  validate :valid_url
  
  scope :checked, -> { where checked: true }
  scope :unchecked, -> { where checked: false }
  
  def self.notify(sender, receiver, action, item_id=1)
    if sender.present? and receiver.present? and sender != receiver
      if sender
        name = sender.name.capitalize
      else
        sender = User.first
      end
      case action
        when :post_comment
          message = name + " " + Translation.translate("commented on your post.")
        when :article_comment
          message = name + " " + Translation.translate("commented on your article.")
        when :banner_comment
          message = name + " " + Translation.translate("commented on your banner.")
        when :translation_comment
          message = name + " " + Translation.translate("commented on your translation.")
        when :activity_comment
          message = name + " " + Translation.translate("commented on your activity.")
        when :event_comment
          message = name + " " + Translation.translate("commented on your event.")
        when :poll_comment
          message = name + " " + Translation.translate("commented on your poll.")
        when :comment_reply
          message = name + " " + Translation.translate("replied to your comment.")
        when :event_invitation
          message = name + " " + Translation.translate("invited you to their event.")
        when :like_post
          message = name + " " + Translation.translate("liked your post.")
        when :going
          message = name + " " + Translation.translate("RSVPed for your event.")
        when :user_feedback
          message = name + " " + Translation.translate("reviewed your profile.")
        when :mention
          message = name + " " + Translation.translate("mentioned you in a post.")
        when :sales_inquiry
          message = name + " " + Translation.translate("inquired upon your offer.")
        when :sales_reply
          message = name + " " + Translation.translate("replied to your inquiry.")
        when :sale_finalized
          message = name + " " + Translation.translate("finalized the offer.")
        when :message
          message = name + " " + Translation.translate("sent you a message.")
        when :you_won
          message = Translation.translate("You won! Call 555-5454 now!")
        when :event_approved
          message = Translation.translate("Your event was approved.")
        when :event_denied
          message = Translation.translate("Your event was denied.")
        when :tab_approved
          message = Translation.translate("Your tab was approved.")
        when :tab_denied
          message = Translation.translate("Your tab was denied.")
      end
      note = receiver.notes.new(message: message, sender_id: sender.id,
        action: action.to_s, item_id: item_id)
      note.save 
    end
  end
  
  private
  
  def valid_url
    if url.present? and not url.include? "http"
      errors.add(:invalid_url, "Invalid URL. Try prepending http://")
    end
  end
end
