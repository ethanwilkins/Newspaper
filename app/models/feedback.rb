class Feedback < ActiveRecord::Base
  belongs_to :article
  belongs_to :comment
  belongs_to :event
  belongs_to :user
  belongs_to :post
  belongs_to :tab
  
  def self.avg_rating item
    if item.feedbacks.present?; amount_rated = 0
      total = 0 and for rating in item.feedbacks
        if rating.stars
          total += rating.stars
          amount_rated += 1
        end
      end
      return total / amount_rated
    else
      return 0
    end
  end
end
