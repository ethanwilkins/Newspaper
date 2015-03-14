class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates_presence_of :action
  before_save :get_location, if: :these_actions?
  
  def get_location
    geoip = GeoIP.new('GeoLiteCity.dat').city(self.ip)
    if defined? geoip and geoip
      self.latitude = geoip.latitude
      self.longitude = geoip.longitude
      if latitude and longitude
        geocoder = Geocoder.search("#{latitude}, #{longitude}").first
        if geocoder and geocoder.formatted_address
          self.address = geocoder.formatted_address
        end
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
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
  
  def self.log_action(user, ip, action="visit", item_id=nil,
    data_string=nil, item_type=nil, browser_name=nil, mobile=nil)
    params = { action: action, ip: ip, item_id: item_id, data_string: data_string,
      item_type: item_type, browser_name: browser_name, mobile: mobile }
    if user and not user.master
      user.activities.create params
    elsif not user
      Activity.create params
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
  
  def these_actions?
    case action
    when "sessions_create", "admin_index", "admin_index_fail",
      "activities_index", "codes_index", "groups_index", "activities_get_location"
      return true
    end
  end
end
