module SearchHelper
  def get_result(search)
    case search.class.to_s
      when "User"
        return User.find search.id
      when "Post"
        return Post.find search.id
      when "Article"
        return Article.find search.id
      when "Comment"
        return Comment.find search.id
      when "Event"
        return Event.find search.id
      when "Tab"
        return Tab.find search.id
    end
  end
end
