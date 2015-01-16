class Feature < ActiveRecord::Base
  belongs_to :tab
  validates_presence_of :action
  validate :unique_in_tab
  
  def self.page_jump(user)
    last_jump = where(user_id: user.id, action: "page_jump").last
    fav_tab = Tab.find_by_id(last_jump.tab_id) if last_jump
    return fav_tab ? fav_tab : nil
  end
  
  private
  
  def unique_in_tab
    if tab_id and Tab.find(tab_id).features.exists? action: action
      errors.add(:already_in_tab, "This feature has already been added.")
    end
  end
end
