class Translation < ActiveRecord::Base
  validates_presence_of :english, :spanish
  has_many :comments
  
  def self.translate(english)
    spanish = self.where(english: english)
    return spanish.present? ? spanish.last.spanish : english
  end
  
  def self.translate_to_english(spanish)
    english = self.where(spanish: spanish)
    return english.present? ? english.last.english : spanish
  end
end
