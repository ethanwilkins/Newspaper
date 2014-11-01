class Comment < ActiveRecord::Base
  belongs_to :translation
  belongs_to :article
  # for comment replies
  belongs_to :comment
  belongs_to :post
  
  has_many :comments
  has_many :hashtags
  
  validates_presence_of :text
end
