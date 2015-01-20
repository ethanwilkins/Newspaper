class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
  def prevalence(user)
    return Search.where(user_id: user.id).
      where(chosen_result_type: chosen_result_type).
      where(chosen_result_id: chosen_result_id).size
  end
  
  def self.recent(user)
    results = []
    recent_searches = where(user_id: user.id).
      where.not(chosen_result_type: [nil, ""]).
      sort_by(&:created_at).sort_by { |search|
        search.prevalence(user) }.reverse
    for search in recent_searches
      result = get_result search
      unless results.include? result or result.nil?
        results << result
      end
    end
    return results
  end
  
  def self.users(query)
    results = []
    for user in User.all; rank = [0]
      scan(user.name, query, rank)
      scan(user.bio, query, rank)
      searches(user, query, rank)
      if rank[0] > 0
        results << [user, rank[0]]
      end
    end
    return results
  end
  
  def self.posts(query)
    results = []
    for post in Post.all; rank = [0]
      scan(post.body, query, rank)
      hashtags(post, query, rank)
      searches(post, query, rank)
      if rank[0] > 0
        results << [post, rank[0]]
      end
    end
    return results
  end
  
  def self.articles(query)
    results = []
    for article in Article.articles; rank = [0]
      if article.ad.nil?
        scan(article.title, query, rank)
        scan(article.body, query, rank)
        hashtags(article, query, rank)
        searches(article, query, rank)
        if rank[0] > 0
          results << [article, rank[0]]
        end
      end
    end
    return results
  end
  
  def self.comments(query)
    results = []
    for comment in Comment.public_comments; rank = [0]
      scan(comment.body, query, rank)
      hashtags(comment, query, rank)
      searches(comment, query, rank)
      if rank[0] > 0
        results << [comment, rank[0]]
      end
    end
    return results
  end
  
  def self.events(query)
    results = []
    for event in Event.approved; rank = [0]
      scan(event.title, query, rank)
      scan(event.body, query, rank)
      hashtags(event, query, rank)
      searches(event, query, rank)
      if rank[0] > 0
        results << [event, rank[0]]
      end
    end
    return results
  end
  
  def self.tabs(query)
    results = []
    for tab in Tab.all; rank = [0]
      scan(tab.name, query, rank)
      scan(tab.description, query, rank)
      hashtags(tab, query, rank)
      searches(tab, query, rank)
      if rank[0] > 0
        results << [tab, rank[0]]
      end
    end
    return results
  end
  
  def self.hashtags(item, query, rank)
    for tag in item.hashtags
      scan(tag.tag, query, rank)
    end
  end
  
  # adds rank for previously searched
  def self.searches(item, query, rank)
    searches = self.where(chosen_result_type: item.class.to_s).
      where(chosen_result_id: item.id)
    if searches.present?
      for search in searches
        scan(search.query, query, rank)
      end
    end
  end
  
  # core of search engine
  def self.scan(text, query, rank)
    if text.present?
      for word in text.split(" ")
        for key_word in query.split(" ")
          if key_word.size > 3
            if word == key_word.downcase or word == key_word.capitalize
              rank[0] += (word.size + key_word.size)
            elsif word.include? key_word.downcase or word.include? key_word.capitalize
              rank[0] += key_word.size
            end
          end
        end
      end
    end
  end
  
  # creates new search with query and user
  def self.new_search(query, user)
    search = self.create(query: query, user_id: (user ? user.id : nil))
    return search if search
  end
  
  # completes search item with chosen result
  def self.save_search(search_id, chosen_result)
    search = self.find_by_id(search_id)
    search.update(chosen_result_type: chosen_result.class.to_s,
      chosen_result_id: chosen_result.id)
  end
  
  # gets result from search
  def self.get_result(search)
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
  
  def get_item(item_class, item_id)
    case item_class.to_s
      when "User"
        return User.find_by_id item_id
      when "Post"
        return Post.find_by_id item_id
      when "Article"
        return Article.find_by_id item_id
      when "Comment"
        return Comment.find_by_id item_id
      when "Event"
        return Event.find_by_id item_id
      when "Tab"
        return Tab.find_by_id item_id
    end
  end
end
