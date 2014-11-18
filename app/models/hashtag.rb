class Hashtag < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :comment
  
  validates :tag, presence: true
  
  def item
    Post.find(post_id) if post_id
  end
  
  def self.tagged(_tag)
    if _tag.include? "#"
      where "tag = ?", _tag.downcase
    else
      where "tag = ?", "#" + _tag.downcase
    end
  end
  
  def self.extract(post)
    text = post.body
    # extracts hashtags from post.text
    text.split(' ').each do |tag|
      if tag.include? "#"
        # removes tag from text
        text.slice! tag
        # updates body without tag
        Post.find(post.id).update(body: text)
        # pushes each tag into post
        post.hashtags.create(tag: tag)
      end
    end
  end
end
