class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :post
  # for comment replies
  belongs_to :comment
  has_many :comments
  has_many :hashtags
end
