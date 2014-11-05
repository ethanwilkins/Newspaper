class Activity < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :action
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode
  
  def self.log_action(user, ip, action="visit", item_id=nil, data_string=nil)
    if user
      user.activities.create action: action, ip: ip, item_id: item_id, data_string: data_string
    else
      Activity.create action: action, ip: ip, item_id: item_id, data_string: data_string
    end
  end
  
  def self.unique_visit_count
    visit_count = 0
    visits_counted = []
    for visit in Activity.all
      unless visits_counted.any? { |_visit| _visit.ip == visit.ip } or \
        visits_counted.any? { |_visit| _visit.user_id == visit.user_id }
        visits_counted << visit
        visit_count += 1
      end
    end
    return visit_count
  end
end
