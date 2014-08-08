class Ad < ActiveRecord::Base
  validates_numericality_of :zip_code
  validates_presence_of :image, :advertiser
  
  mount_uploader :image, ImageUploader
end
