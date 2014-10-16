class WelcomeController < ApplicationController
  def index
    # resets back to top
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @all_articles = Article.all.reverse
    @articles = Article.all.reverse.
      # drops first several posts if :page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
    @banner = Banner.last
    @user = User.new
    if current_user
      @advert = Article.local_advert(current_user)
    end
  end
end
