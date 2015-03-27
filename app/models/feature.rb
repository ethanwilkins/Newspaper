class Feature < ActiveRecord::Base
  belongs_to :tab
  belongs_to :user
  belongs_to :subtab
  validates_presence_of :action, on: :create
  validate :unique_for_user, on: :create
  validate :unique_in_tab, on: :create
  
  def self.page_jump(user)
    last_jump = where(user_id: user.id, action: "page_jump").last
    fav_tab = Tab.find_by_id(last_jump.tab_id) if last_jump
    return fav_tab ? fav_tab : nil
  end
  
  private
  
  def unique_for_user
    if tab_id.nil? and User.find(user_id).features.exists? action: action \
      and not [:cherry_pick, :page_jump].include? action
      errors.add(:already_added_to_user, "This feature has already been added.")
    end
  end
  
  def unique_in_tab
    if not personal and ((tab_id and Tab.find(tab_id).features.exists? action: action) \
      or (subtab_id and Subtab.find(subtab_id).features.exists? action: action))
      errors.add(:already_in_tab, "This feature has already been added.")
    end
  end
end
