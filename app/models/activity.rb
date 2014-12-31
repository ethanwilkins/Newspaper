class Activity < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  validates_presence_of :action
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode, if: :these_actions?
  
  before_save :save_zip
  
  def get_location
    result = Geocoder.search(self.ip).first
    self.address = result.address
    self.latitude = result.latitude
    self.longitude = result.longitude
    if address.present?
      self.save!
      return true
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
  
  def self.log_action(user, ip, action="visit", item_id=nil, data_string=nil)
    if user and not user.master
      user.activities.create action: action, ip: ip, item_id: item_id, data_string: data_string
    elsif not user
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
  
  def these_actions?
    case action
    when "sessions_create", "admin_index", "admin_index_fail",
      "activities_index", "codes_index", "groups_index"
      return true
    end
  end
  
  def save_zip
    if self.address.present?
      place = self.address.split(", ")[2] if self.address.split(", ")[2].present?
      zip = place.split(" ")[1] if place and place.split(" ")[1].present?
      self.zip_code = place.split(" ")[1].to_i if zip and zip.size == 5
    end
  end
end
