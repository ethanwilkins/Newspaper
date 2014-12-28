class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
  def self.scan_users(query)
    results = []
    for user in User.all
      if scan(user.name, query) or scan(user.bio, query)
        results << user 
      end
    end
    return results
  end
  
  def self.scan_posts(query)
    results = []
    for post in Post.all
      if scan(post.body, query)
        results << post 
      end
      scan_hashtags post, query, results
    end
    return results
  end
  
  def self.scan_articles(query)
    results = []
    for article in Article.all
      if article.ad.nil? and (scan(article.title, query) or scan(article.body, query))
        results << article 
      end
      scan_hashtags article, query, results
    end
    return results
  end
  
  def self.scan_comments(query)
    results = []
    for comment in Comment.all
      if scan(comment.body, query)
        results << comment 
      end
    end
    return results
  end
  
  def self.scan_events(query)
    results = []
    for event in Event.all
      if scan(event.title, query) or scan(event.body, query)
        results << event 
      end
    end
    return results
  end
  
  def self.scan_tabs(query)
    results = []
    for tab in Tab.all
      if scan(tab.name, query) or scan(tab.description, query)
        results << tab 
      end
    end
    return results
  end
  
  def self.scan_hashtags(item, query, results)
    for tag in item.hashtags
      if scan(tag.tag, query)
        unless results.include? item
          results << item
        end
      end
    end
  end
  
  def self.scan(text, query)
    found = false
    if text.present?
      for word in text.split(" ")
        if word.include? query.downcase or word.include? query.capitalize
          found = true
        end
      end
    end
    return found
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
