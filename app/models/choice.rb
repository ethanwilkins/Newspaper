class Choice < ActiveRecord::Base
  belongs_to :poll
  has_many :votes
  
  def score
    Vote.score(self)
  end
end
