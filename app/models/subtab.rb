class Subtab < ActiveRecord::Base
  belongs_to :tab
  
  has_many :posts
  has_many :events, dependent: :destroy
  has_many :features, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :loading_gifs, dependent: :destroy
  has_many :translations, dependent: :destroy
  has_many :members, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
  
  def cherry_picked?(user)
    cherry_picks = self.features.where(action: :cherry_pick)
    if cherry_picks.find_by_user_id(user.id)
      return true
    else
      return false
    end
  end
  
  def list_format?
    features.exists? action: "list_format"
  end
  
  def approved_articles
    articles.where requires_approval: [nil, false]
  end
  
  def funnel_tagged
    funneled = []
    if features.exists? action: :tagged
      for tag in hashtags
        tag.tagged.each do |_tag|
          funneled << _tag
        end
      end
    end
    return funneled.sort_by &:created_at
  end
  
  def popularity
    posts.size
  end
end
