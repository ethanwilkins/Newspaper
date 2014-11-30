class Translation < ActiveRecord::Base
  belongs_to :post
  belongs_to :article
  belongs_to :event
  belongs_to :tab
  
  has_many :comments
  
  validate :spanish_or_english
  
  def self.requests
    _requests = []
    where(english: [nil, ""]).each { |_request| _requests << _request }
    where(spanish: [nil, ""]).each { |_request| _requests << _request }
    return _requests.sort_by(&:id)
  end
  
  def self.translated
    _translated = []
    for _translation in self.all
      if _translation.english.present? and _translation.spanish.present?
        _translated << _translation
      end
    end
    return _translated
  end
  
  def self.translate(english)
    spanish = self.where("english = ? AND request != ?", english, true)
    return spanish.present? ? spanish.last.spanish : english
  end
  
  def self.translate_to_english(spanish)
    english = self.where("spanish = ? AND request != ?", spanish, true)
    return english.present? ? english.last.english : spanish
  end
  
  private
  
  def spanish_or_english
    if (request.nil? and (spanish.nil? or english.nil?)) or (request and spanish.nil? and english.nil?)
      errors.add(:no_spanish_or_english, "Invalid input.")
    end
  end
end
