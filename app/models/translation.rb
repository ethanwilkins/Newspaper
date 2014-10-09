class Translation < ActiveRecord::Base
  validates_presence_of :english, :spanish
end
