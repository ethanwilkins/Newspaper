class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :comment
  belongs_to :event
  belongs_to :tab
  
  validates :tag, presence: true
  
  def tagged(item)
    for tag in item.hashtags
      if tag.tag == self.tag
        
      end
    end
  end
  
  def item
    if post_id
      Post.find(post_id)
    elsif comment_id
      Comment.find(comment_id)
    elsif article_id
      Article.find(article_id)
    end
  end
  
  def self.extract(item)
    text = item.body
    text.split(' ').each do |word|
      if word.include? "#" and word.size > 1
        item.hashtags.create(tag: word, user_id: item.user_id, index: text.index(word))
      end
    end
  end
end
