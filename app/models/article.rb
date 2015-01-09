class Article < ActiveRecord::Base  
  has_many :comments, dependent: :destroy
  has_many :translations, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  
  validates_presence_of :body, :title
  
  mount_uploader :image, ImageUploader
  
	scope :articles, -> { where ad: [nil, false] }
  
  def self.local_advert(user)
    zip_code = (user ? user.zip_code : 27577)
    local_ads = where(ad: true, zip_code: zip_code)
    local_ad = local_ads.limit(Random.new.rand 1..local_ads.size).last if local_ads.size > 0
    local_ad.view if local_ad
    return local_ad
  end
  
  def self.ads
    where ad: true
  end
  
  def view
    update views: views.to_i + 1
  end
  
  def score
    comments.size
  end
end
