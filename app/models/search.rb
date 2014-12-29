class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
  def self.scan_users(query)
    results = []
    for user in User.all; rank = [0]
      scan(user.name, query, rank)
      scan(user.bio, query, rank)
      if rank[0] > 0
        results << [user, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_posts(query)
    results = []
    for post in Post.all; rank = [0]
      scan(post.body, query, rank)
      scan_hashtags(post, query, rank)
      if rank[0] > 0
        results << [post, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_articles(query)
    results = []
    for article in Article.all; rank = [0]
      if article.ad.nil?
        scan(article.title, query, rank)
        scan(article.body, query, rank)
        scan_hashtags(article, query, rank)
        if rank[0] > 0
          results << [article, rank[0]]
        end
      end
    end
    return results
  end
  
  def self.scan_comments(query)
    results = []
    for comment in Comment.all; rank = [0]
      scan(comment.body, query, rank)
      scan_hashtags(comment, query, rank)
      if rank[0] > 0
        results << [comment, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_events(query)
    results = []
    for event in Event.all; rank = [0]
      scan(event.title, query, rank)
      scan(event.body, query, rank)
      if rank[0] > 0
        results << [event, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_tabs(query)
    results = []
    for tab in Tab.all; rank = [0]
      scan(tab.name, query, rank)
      scan(tab.description, query, rank)
      if rank[0] > 0
        results << [tab, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_hashtags(item, query, rank)
    for tag in item.hashtags
      scan(tag.tag, query, rank)
    end
  end
  
  # will add weight to items that have been
  # chosen often in relation to query
  def self.scan_searches(item, query, rank)
    searches = self.where(query: query)
    if searches.present?
      for search in searches
        
      end
    end
  end
  
  def self.scan(text, query, rank)
    if text.present?
      for word in text.split(" ")
        for key_word in query.split(" ")
          if word.include? key_word.downcase or word.include? key_word.capitalize
            rank[0] += 1
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
end
