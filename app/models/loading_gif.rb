class LoadingGif < ActiveRecord::Base
  belongs_to :user
  belongs_to :tab
  belongs_to :subtab
  
  mount_uploader :image, ImageUploader
  
  def self.default
    gif = where(subtab_id: nil).
    where(user_id: nil).
    where(tab_id: nil).
    last
    if gif
      return gif.image
    else
      return nil
    end
  end
end
