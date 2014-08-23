class Article < ActiveRecord::Base
  has_many :comments
  
  mount_uploader :image, ImageUploader
  
  def self.local_advert(user)
    local_ads = where(ad: true, zip_code: user.zip_code)
    local_ad = local_ads.limit(Random.new.rand 1..local_ads.size).last if local_ads.size > 0
    local_ad.view
    return local_ad
  end
  
  def self.ads
    where ad: true
  end
  
  def view
    update views: views.to_i + 1
  end
end
