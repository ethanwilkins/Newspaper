class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :translate

  private
  
  def translate(english)
    # takes string and searches Translation.all for a match unless user.english
    unless current_user and current_user.english
      spanish = Translation.where(english: english)
    end
    return spanish.present? ? spanish.last.spanish : english
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
