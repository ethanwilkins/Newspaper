class Feature < ActiveRecord::Base
  belongs_to :tab
  validates_presence_of :action
  
  def self.page_jump(user)
    last_jump = where(user_id: user.id, action: "page_jump").last
    fav_tab = Tab.find_by_id(last_jump.tab_id) if last_jump
    return fav_tab ? fav_tab : nil
  end
end
