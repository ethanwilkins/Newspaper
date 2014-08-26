class WelcomeController < ApplicationController
  def index
    @articles = Article.all.reverse
    @banner = Banner.last
    @user = User.new
    if current_user
      @advert = Article.local_advert(current_user)
    end
  end
end
