class Code < ActiveRecord::Base
  validate :code, presence: true
  validate :is_a_board, presence: true
  
  mount_uploader :image, ImageUploader
end
