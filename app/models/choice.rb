class Choice < ActiveRecord::Base
  belongs_to :poll
  belongs_to :user
  has_many :votes
end
