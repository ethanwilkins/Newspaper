class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
  def self.scan_users(query)
    results = []
    for user in User.all; rank = [0]
      if scan(user.name, query, rank) or \
        scan(user.bio, query, rank)
        results << [user, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_posts(query)
    results = []
    for post in Post.all; rank = [0]
      if scan(post.body, query, rank)
        results << [post, rank[0]]
      end
      scan_hashtags post, query, results
    end
    return results
  end
  
  def self.scan_articles(query)
    results = []
    for article in Article.all; rank = [0]
      if article.ad.nil? and (scan(article.title, query, rank) or \
        scan(article.body, query, rank))
        results << [article, rank[0]]
      end
      scan_hashtags article, query, results
    end
    return results
  end
  
  def self.scan_comments(query)
    results = []
    for comment in Comment.all; rank = [0]
      if scan(comment.body, query, rank)
        results << [comment, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_events(query)
    results = []
    for event in Event.all; rank = [0]
      if scan(event.title, query, rank) or \
        scan(event.body, query, rank)
        results << [event, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_tabs(query)
    results = []
    for tab in Tab.all; rank = [0]
      if scan(tab.name, query, rank) or \
        scan(tab.description, query, rank)
        results << [tab, rank[0]]
      end
    end
    return results
  end
  
  def self.scan_hashtags(item, query, results)
    for tag in item.hashtags; rank = [0]
      if scan(tag.tag, query, rank)
        unless results.select { |result| result[0] == item }.present?
          results << [item, rank[0]]
        end
      end
    end
  end
  
  def self.scan(text, query, rank)
    found = false
    if text.present?
      for word in text.split(" ")
        for key_word in query.split(" ")
          if word.include? key_word.downcase or \
            word.include? key_word.capitalize
            found = true
            rank[0] += 1
          end
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
