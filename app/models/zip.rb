class Zip < ActiveRecord::Base
  validates_uniqueness_of :zip_code
  
  def self.record(zip)
    unless self.find_by_zip_code(zip) or zip.nil?
      self.create zip_code: zip
    end
  end
end
