class Member < ActiveRecord::Base
  belongs_to :folder
  belongs_to :group
  belongs_to :event
  belongs_to :subtab
  belongs_to :tab
  belongs_to :tournament
  belongs_to :sports_match
end
