class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
  # scan needs to be able to add weight from tags or other
  # attributes even when first attribute scan returns true
  # need to separate true/false from adding weight to rank
  
  def self.scan_users(query)
    results = []
    for user in User.all; rank = [0]
      if scan(user.name, query, rank) or scan(user.bio, query, rank)
        results << [user, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_posts(query)
    results = []
    for post in Post.all; rank = [0]
      if scan(post.body, query, rank) or scan_hashtags(post, query, rank)
        results << [post, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_articles(query)
    results = []
    for article in Article.all; rank = [0]
      if article.ad.nil? and (scan(article.title, query, rank) or \
        scan(article.body, query, rank) or scan_hashtags(article, query, rank))
        results << [article, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_comments(query)
    results = []
    for comment in Comment.all; rank = [0]
      if scan(comment.body, query, rank) or scan_hashtags(comment, query, rank)
        results << [comment, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_events(query)
    results = []
    for event in Event.all; rank = [0]
      if scan(event.title, query, rank) or scan(event.body, query, rank)
        results << [event, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_tabs(query)
    results = []
    for tab in Tab.all; rank = [0]
      if scan(tab.name, query, rank) or scan(tab.description, query, rank)
        results << [tab, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_hashtags(item, query, rank)
    found = false
    for tag in item.hashtags
      if scan(tag.tag, query, rank)
        found = true
      end
    end
    return found
  end
  
  def self.scan(text, query, rank)
    found = false
    if text.present?
      for word in text.split(" ")
        for key_word in query.split(" ")
          if word.include? key_word.downcase or word.include? key_word.capitalize
            found = true
            rank[0] += 1
          end
        end
      end
    end
    return found
  end
  
  # will add weight to items that have been
  # chosen often in relation to query
  def self.scan_searches(query, item)
    searches = self.where(query: query)
    if searches
      for search in searches
        
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
end
