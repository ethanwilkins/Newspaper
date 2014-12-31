class Note < ActiveRecord::Base
  belongs_to :user
  validates :message, presence: true
  validate :valid_url
  
  def self.checked
    where(checked: true)
  end
  
  def self.unchecked
    where(checked: false)
  end
  
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
        when :translation_comment
          message = name + " " + Translation.translate("commented on your translation.")
        when :activity_comment
          message = name + " " + Translation.translate("commented on your activity.")
        when :event_comment
          message = name + " " + Translation.translate("commented on your event.")
        when :comment_reply
          message = name + " " + Translation.translate("replied to your comment.")
        when :like_post
          message = name + " " + Translation.translate("liked your post.")
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
      receiver.notes.create!(message: message, sender_id: sender.id,
        action: action.to_s, item_id: item_id)
    end
  end
  
  private
  
  def valid_url
    if url.present? and not url.include? "http"
      errors.add(:invalid_url, "Invalid URL. Try prepending http://")
    end
  end
end
