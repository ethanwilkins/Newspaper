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
    if self != sender then
      name = sender.name.capitalize
      case action
        when :post_comment
          message = "#{name} commented on your post."
        when :article_comment
          message = "#{name} commented on your article."
        when :comment_reply
          message = "#{name} replied to your comment."
      end
      receiver.notes.create!(message: message, other_user_id: sender.id,
        action: action.to_s, item_id: item_id)
    end
  end
end
