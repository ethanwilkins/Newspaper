class Member < ActiveRecord::Base
  belongs_to :folder
  belongs_to :group
  belongs_to :event
end
