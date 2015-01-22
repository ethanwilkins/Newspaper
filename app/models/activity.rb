class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates_presence_of :action
  
  reverse_geocoded_by :latitude, :longitude, :address => :address

  after_save :get_location, if: :these_actions?
  after_save :geocode, :reverse_geocode, if: :these_actions?
  
  def get_location
    geoip = GeoIP.new('GeoLiteCity.dat').city(self.ip)
    if defined? geoip
      self.address = geoip.city_name
      # need country name, need to get
      # longitudes or minimum to get state
      # and city names from geocode
      self.latitude = geoip.latitude
      self.longitude = geoip.longitude
      if latitude and longitude
        self.save!
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
  
  def self.log_action(user, ip, action="visit", item_id=nil, data_string=nil, item_type=nil)
    params = { action: action, ip: ip, item_id: item_id, data_string: data_string, item_type: item_type }
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
    # case action
    # when "sessions_create", "admin_index", "admin_index_fail",
    #   "activities_index", "codes_index", "groups_index"
    #   return true
    # end
    return false # temporary stopgap
  end
  
  def save_zip
    if self.address.present?
      place = self.address.split(", ")[2] if self.address.split(", ")[2].present?
      zip = place.split(" ")[1] if place and place.split(" ")[1].present?
      self.zip_code = place.split(" ")[1].to_i if zip and zip.size == 5
    end
  end
end
