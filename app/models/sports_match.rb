class SportsMatch < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :tab
  has_many :members
end
