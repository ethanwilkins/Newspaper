class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :translate, :page_size, :name_shown

  private
  
  def page_size
    @page_size = 5
  end
  
  def name_shown(item)
    if (current_user and current_user.english and item.english_name.present?) or \
      (request.host.to_s.include? "elhero.com" and not (current_user and not current_user.english))
      item.english_name
    else
      item.name
    end
  end
  
  def translate(english)
    # takes string and searches Translation.all for a match unless user.english
    if (current_user and current_user.english) or (request.host.to_s.include? "elhero.com" and \
      not (current_user and not current_user.english))
      spanish = nil
    else
      spanish = Translation.where(english: english)
    end
    return spanish.present? ? spanish.last.spanish : english
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
