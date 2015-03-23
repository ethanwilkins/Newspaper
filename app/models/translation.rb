class Translation < ActiveRecord::Base
  belongs_to :post
  belongs_to :event
  belongs_to :article
  belongs_to :subtab
  belongs_to :user
  belongs_to :tab
  
  has_many :comments
  
  validate :spanish_or_english

	def self.language(text)
		wl = WhatLanguage.new(:english, :spanish)
		return wl.language(text)
	end
  
  def self.translator text
    unless language(text).nil?
      translator = BingTranslator.new('EFW-1993',
        ENV['BING_TRANSLATOR_CLIENT_SECRET'])
      if language(text).eql? :english
        translator.translate(text, :from => 'en', :to => 'es')
      elsif language(text).eql? :spanish
        translator.translate(text, :from => 'es', :to => 'en')
      end
    end
  end
  
  def self.translate(english)
    spanish = self.site_english(english)
    return spanish.present? ? spanish.last.spanish : english
  end
  
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
  
  def self.translate_to_english(spanish)
    english = self.site_spanish(spanish)
    return english.present? ? english.last.english : spanish
  end
  
  # site translations are not tied to any model but
  # to the site itself through links and buttons or other labels
  
  def self.site_spanish(_spanish)
    _site_spanish = []
    for _translation in self.site
      if _translation.spanish == _spanish
        _site_spanish << _translation
      end
    end
    return _site_spanish
  end
  
  def self.site_english(_english)
    _site_english = []
    for _translation in self.site
      if _translation.english == _english
        _site_english << _translation
      end
    end
    return _site_english
  end
  
  def self.site
    translations = []
    for translation in self.
      where(tab_id: nil).
      where(post_id: nil).
      where(event_id: nil).
      where(subtab_id: nil).
      where(article_id: nil)
      translations << translation
    end
    return translations
  end
  
  private
  
  def spanish_or_english
    if (request.nil? and (spanish.nil? or english.nil?)) or (request and spanish.nil? and english.nil?)
      errors.add(:no_spanish_or_english, "Invalid input.")
    end
  end
end
