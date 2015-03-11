class Tip < ActiveRecord::Base
	belongs_to :user
  validates_presence_of :kind
end
