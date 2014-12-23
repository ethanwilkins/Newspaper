class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :comment
  
  validates :tag, presence: true
  
  def item
    if post_id
      Post.find(post_id)
    elsif comment_id
      Comment.find(comment_id)
    elsif article_id
      Article.find(article_id)
    end
  end
  
  def self.tagged(_tag)
    if _tag.include? "#"
      where "tag = ?", _tag.downcase
    else
      where "tag = ?", "#" + _tag.downcase
    end
  end
  
  def self.extract(item)
    text = item.body
    # extracts hashtags from post.text
    text.split(' ').each do |tag|
      if tag.include? "#"
        # removes tag from text
        text.slice! tag
        # pushes each tag into post
        item.hashtags.create(tag: tag)
        # updates body without tag
        Post.find(item.id).update(body: text) if item.kind_of? Post
        Article.find(item.id).update(body: text) if item.kind_of? Article
        Comment.find(item.id).update(body: text) if item.kind_of? Comment
      end
    end
  end
end
