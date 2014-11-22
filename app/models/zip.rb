class Zip < ActiveRecord::Base
  belongs_to :group
  validates_uniqueness_of :zip_code
  
  ZIP_CODE_RANGE = 10
  
  def density
    zips_in_range = []
    for zip in Zip.all
      difference = (self.zip_code - zip.zip_code).abs
      if difference < ZIP_CODE_RANGE
        zips_in_range << zip.zip_code
      end
    end
    return zips_in_range.size
  end
  
  def self.record(zip)
    unless self.find_by_zip_code(zip) or zip.nil?
      self.create zip_code: zip
    end
  end
  
  def self.zip_code_range
    ZIP_CODE_RANGE
  end
end
