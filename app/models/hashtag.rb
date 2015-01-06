class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :comment
  belongs_to :event
  belongs_to :tab
  
  validates :tag, presence: true
  
  def tagged
    _tagged = []
    for post in Post.all
      if post.hashtags.exists? tag: tag
        _tagged << post
      end
    end
    for article in Article.articles
      if article.hashtags.exists? tag: tag
        _tagged << article
      end
    end
    for comment in Comment.all
      if comment.hashtags.exists? tag: tag
        _tagged << comment
      end
    end
    for event in Event.approved
      if event.hashtags.exists? tag: tag
        _tagged << event
      end
    end
    return _tagged
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
