class Activity < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :action
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude,
    :region_code => :region_code, :city => :city
  after_validation :geocode
  before_save :save_zip_code
  
  def self.unique_locations
    _unique_locations = []
    for act in Activity.all
      unless _unique_locations.any? { |_act| _act.latitude == act.latitude } or \
        _unique_locations.any? { |_act| _act.longitude == act.longitude } or act.latitude.nil?
        _unique_locations << act
      end
    end
    return _unique_locations
  end
  
  def self.log_action(user, ip, action="visit", item_id=nil, data_string=nil)
    if user
      user.activities.create action: action, ip: ip, item_id: item_id, data_string: data_string
    else
      Activity.create action: action, ip: ip, item_id: item_id, data_string: data_string
    end
  end
  
  def self.unique_visits
    visits = []
    for visit in Activity.all
      unless visits.any? { |_visit| _visit.ip == visit.ip } or \
        (visits.any? { |_visit| _visit.user_id == visit.user_id } and visit.user_id.present?)
        visits << visit
      end
    end
    return visits
  end
  
  private
  
  def save_zip_code
    zip_code = [city, region_code].to_zip if [city, region_code].to_zip
  end
end
