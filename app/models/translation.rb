class Translation < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :event
  belongs_to :tab
  
  has_many :comments
  
  validate :spanish_or_english
  
  def self.translate(english)
    spanish = self.where("english = ? AND requested != ?", english, true)
    return spanish.present? ? spanish.last.spanish : english
  end
  
  def self.translate_to_english(spanish)
    english = self.where("spanish = ? AND requested != ?", spanish, true)
    return english.present? ? english.last.english : spanish
  end
  
  private
  
  def spanish_or_english
    if (request.nil? and (spanish.nil? or english.nil?)) or (request and spanish.nil? and english.nil?)
      errors.add(:no_spanish_or_english, "Invalid input.")
    end
  end
end
