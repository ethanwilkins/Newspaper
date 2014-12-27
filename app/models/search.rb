class Search < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :query
  
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
