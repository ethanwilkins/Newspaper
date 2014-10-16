class Translation < ActiveRecord::Base
  validates_presence_of :english, :spanish
  
  def self.translate(english)
    spanish = self.where(english: english)
    return spanish.present? ? spanish.last.spanish : english
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
