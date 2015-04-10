class Tournament < ActiveRecord::Base
	has_many :sports_matches
	has_many :members
  belongs_to :tab
end
