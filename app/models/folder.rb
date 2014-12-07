class Folder < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :members, dependent: :destroy
  has_one :post
  
  def notify_members(sender)
    for member in members
      if member != sender
        User.find(member.user_id).notify!(:message, sender, id)
      end
    end
  end
  
  def self.unread_messages(user)
    unread = 0
    folders = Array.new
    Member.where("user_id = ?", user).each do |member|
      folders << find(member.folder) if member.folder
    end
    for folder in folders
      unread += folder.messages.where("seen = ? AND user_id != ?", false, user.id).size
    end
    return unread
  end
  
  def self.inbox_of(user)
    folders = Array.new
    Member.where("user_id = ?", user).each do |member|
      folders << find(member.folder) if member.folder
    end
    folders.sort_by &:updated_at
  end
  
  def self.folder_between(sender, receiver)
    _folder_between = nil
    Member.where("user_id = ?", sender).each do |_sender|
      Member.where("user_id = ?", receiver).each do |_receiver|
        if _sender.folder and _receiver.folder and _sender.folder == _receiver.folder
          _folder_between = find(_sender.folder)
        end
      end
    end
    return _folder_between
  end
end
