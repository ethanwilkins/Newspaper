class Tab < ActiveRecord::Base
  has_many :posts
  has_many :events, dependent: :destroy
  has_many :subtabs, dependent: :destroy
  has_many :features, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :translations, dependent: :destroy
  
  mount_uploader :icon, ImageUploader
  
  reverse_geocoded_by :latitude, :longitude, :address => :address
  after_validation :geocode, :reverse_geocode
  
  scope :pending, -> { where approved: nil }
  scope :approved, -> { where approved: true }
  
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
  
  def add_hashtags(tags)
    if tags.present?
      for tag in tags.split(", ")
        unless tag.include? " "
          if tag.include? "#"
            hashtags.create tag: tag
          else
            hashtags.create tag: "#" + tag
          end
        end
      end
    end
  end
  
  def cherry_picked?(user)
    cherry_picks = self.features.where(action: :cherry_pick)
    if cherry_picks.find_by_user_id(user.id)
      return true
    else
      return false
    end
  end
  
  def self.most_popular
    self.all.sort_by(&:popularity).last 2
  end
  
  def popular_subtabs
    self.subtabs.sort_by(&:popularity).last 2
  end
  
  # for sorting tabs
  def popularity
    posts.size
  end
end
