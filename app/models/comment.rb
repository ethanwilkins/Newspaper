class Comment < ActiveRecord::Base
  belongs_to :translation
  belongs_to :activity
  belongs_to :article
  belongs_to :comment
  belongs_to :event
  belongs_to :post
  has_many :comments
  has_many :hashtags
  
  validates_presence_of :body, on: :create
  before_update :body_or_tags
  
	scope :public_comments, -> { where(activity_id: nil).
      where(translation_id: nil) }
  
  private
  
  def body_or_tags
    if body.empty? and hashtags.empty?
      errors.add(:body_or_tags_required, "Comments can't be empty.")
    end
  end
end
