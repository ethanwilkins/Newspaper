class Translation < ActiveRecord::Base
  validates_presence_of :english, :spanish
  
  def self.translate(english)
    spanish = self.where(english: english)
    return spanish.present? ? spanish.last.spanish : english
  end
end
