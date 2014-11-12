class Activity < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :action
  
  geocoded_by :ip, :latitude => :latitude, :longitude => :longitude
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  before_save :save_zip
  
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
    case action
    when "sessions_create", "admin_index", "admin_index_fail", "activities_index", "codes_index"
      if user
        user.activities.create action: action, ip: ip, item_id: item_id, data_string: data_string
      else
        Activity.create action: action, ip: ip, item_id: item_id, data_string: data_string
      end
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
  
  def save_zip
    # extracts zip code from full address
    if address.present? and address.split(", ")[2].present?
      place = address.split(", ")[2]
      if place.split(" ")[1].present?
        zip_code = place.split(" ")[1].to_i
      end
    end
  end
end
