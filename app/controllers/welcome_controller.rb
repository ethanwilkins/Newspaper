class WelcomeController < ApplicationController
  def index
    reset_page
    @articles = paginate Article.articles
    @banner = Banner.last
    @user = User.new
    if current_user
      @advert = Article.local_advert(current_user)
    end
    log_action("welcome_index")
  end
end
