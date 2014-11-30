class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :translate, :page_size, :text_shown

  private

  def page_size
    @page_size = 5
  end
  
  def reset_page
    # resets back to top
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
  end
  
  def text_shown(item, field)
    field = field.to_s
    if item.translations.present? and item.translations.find_by_field(field)
      if english?
        return item.translations.find_by_field(field).english
      else
        return item.translations.find_by_field(field).spanish
      end
    else
      return item.attributes[field]
    end
  end
  
  def translate(english)
    if english?
      spanish = nil
    else
      spanish = Translation.where("english = ? AND request != ?", english, true)
    end
    return spanish.present? ? spanish.last.spanish : english
  end
  
  def english?
    (current_user and current_user.english) or (request.host.to_s.include? "elhero.com" and \
      not (current_user and not current_user.english))
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
end
