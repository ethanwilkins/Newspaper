class SearchController < ApplicationController
  def search
    # saves in session for pages
    session[:query] = params[:query]
    if session[:query]
      @query = session[:query]
      @users = User.where "name = ? OR name = ?", @query.capitalize, @query.downcase
      @tags = Hashtag.tagged(session[:query])

      if session[:query] == ""
        @no_results = translate "Empty search."
      elsif @users.empty? and @tags.empty?
        @no_results = translate("No results were found for") + " #{@query}."
      end

      @results = [] # collects results into one array
      @users.each { |user| @results << user }
      @tags.each { |tag| @results << tag }
    end
    @advert = Article.local_advert(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "hashtags_search", nil, params[:query])
  end
end
