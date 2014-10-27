class WelcomeController < ApplicationController
  def index
    # resets back to top
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @articles = Article.all.reverse
    @banner = Banner.last
    @user = User.new
    if current_user
      @advert = Article.local_advert(current_user)
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user, request.remote_ip.to_s, "welcome_index")
  end
end
