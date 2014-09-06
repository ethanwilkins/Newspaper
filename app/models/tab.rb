class Tab < ActiveRecord::Base
  has_many :posts
  has_many :subtabs
  
  mount_uploader :icon, ImageUploader
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
  
  def popular_subtabs
    tab1, tab2 = nil, nil
    popular_tabs = []
    for tab in subtabs
      if (tab1.nil? and tab.posts.present?) \
        or (tab1 and tab1.posts.size < tab.posts.size)
        tab1 = tab
      end
    end
    for tab in subtabs
      if tab != tab1 and ((tab2.nil? and tab.posts.present?) \
        or (tab2 and tab2.posts.size < tab.posts.size))
        tab2 = tab
      end
    end
    popular_tabs << tab1
    popular_tabs << tab2
    return popular_tabs
  end
end
