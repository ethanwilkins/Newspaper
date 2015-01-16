class SearchController < ApplicationController
  def search
    reset_page
    # saves in session for pages
    session[:query] = params[:query]
    if session[:query].present?
      @query = session[:query]
      new_search @query
      
      # scans all item texts for query
      @users = Search.users @query
      @posts = Search.posts @query
      @articles = Search.articles @query
      @comments = Search.comments @query
      @events = Search.events @query
      @tabs = Search.tabs @query

      # one array to rule them all
      @all_results = [] # collects results into one array
      @users.each { |user| @all_results << user }
      @posts.each { |post| @all_results << post }
      @articles.each { |article| @all_results << article }
      @comments.each { |comment| @all_results << comment }
      @events.each { |event| @all_results << event }
      @tabs.each { |tab| @all_results << tab }
      
      # sorts results by rank
      @all_results.sort_by! &:last
      
      # paginates all results as results
      @results = paginate @all_results
      
      # checks if any results were found
      if @all_results.empty? # notifies user when no results are found
        @no_results = translate("No results were found for") + " '#{@query}'"
      end
    else
      @recent_searches = Search.recent(current_user)
    end
    @advert = Article.local_advert(current_user)
    log_action("hashtags_search", nil, params[:query])
  end
end
