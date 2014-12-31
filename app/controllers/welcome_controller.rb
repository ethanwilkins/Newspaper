class WelcomeController < ApplicationController
  def index
    reset_page
    @articles = paginate Article.all
    @banner = Banner.last
    @user = User.new
    if current_user
      @advert = Article.local_advert(current_user)
    end
    # logs the visit with the contextual data
    Activity.log_action(current_user, request.remote_ip.to_s, "welcome_index")
  end
end
