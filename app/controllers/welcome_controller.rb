class WelcomeController < ApplicationController
  def index
    @banner = Banner.last
    @user = User.new
    if current_user
      @articles = Article.all.reverse
      @advert = Article.local_advert(current_user)
    end
  end
end
