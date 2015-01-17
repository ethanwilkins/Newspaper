module SearchHelper
  def get_result(search)
    case search.chosen_result_type.to_s
      when "User"
        return User.find_by_id search.chosen_result_id
      when "Post"
        return Post.find_by_id search.chosen_result_id
      when "Article"
        return Article.find_by_id search.chosen_result_id
      when "Comment"
        return Comment.find_by_id search.chosen_result_id
      when "Event"
        return Event.find_by_id search.chosen_result_id
      when "Tab"
        return Tab.find_by_id search.chosen_result_id
    end
  end
end
