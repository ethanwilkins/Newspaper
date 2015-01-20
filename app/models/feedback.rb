class Feedback < ActiveRecord::Base
  belongs_to :article
  belongs_to :comment
  belongs_to :event
  belongs_to :user
  belongs_to :post
  belongs_to :tab
  
  def self.average item
    
  end
  
  def self.already_starred items, user
    for item in items
      if item.is_a? Post and user.feedbacks.exists? post_id: item.id
        return user.feedbacks.find_by_post_id item.id
      elsif item.is_a? Article and user.feedbacks.exists? article_id: item.id
        return user.feedbacks.find_by_article_id item.id
      elsif item.is_a? Comment and user.feedbacks.exists? comment_id: item.id
        return user.feedbacks.find_by_comment_id item.id
      elsif item.is_a? Event and user.feedbacks.exists? event_id: item.id
        return user.feedbacks.find_by_event_id item.id
      elsif item.is_a? Tab and user.feedbacks.exists? tab_id: item.id
        return user.feedbacks.find_by_tab_id item.id
      else
        return self.new
      end
    end
  end
end
