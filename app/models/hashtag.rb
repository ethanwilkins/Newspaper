class Hashtag < ActiveRecord::Base
  belongs_to :post
  
  validates :tag, presence: true
  
  def item
    Post.find(post_id) if post_id
  end
  
  def self.tagged(_tag)
    where("tag = ?", _tag)
  end
  
  def self.extract(post)
    text = post.body
    # extracts hashtags from post.text
    text.split(' ').each do |tag|
      if tag.include? "#"
        # removes tag from text
        text.slice! tag
        # @post would not update
        Post.find(post.id).update(body: text)
        # pushes each tag into post
        post.hashtags.create(tag: tag)
      end
    end
  end
end
