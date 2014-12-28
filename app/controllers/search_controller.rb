class SearchController < ApplicationController
  def search
    reset_page
    # saves in session for pages
    session[:query] = params[:query]
    if session[:query].present?
      @query = session[:query]
      new_search @query
      
      # scans all item texts for query
      @users = Search.scan_users @query
      @posts = Search.scan_posts @query
      @articles = Search.scan_articles @query
      @comments = Search.scan_comments @query
      @events = Search.scan_events @query
      @tabs = Search.scan_tabs @query

      # one array to rule them all
      @all_results = [] # collects results into one array
      @users.each { |user| @all_results << user }
      @posts.each { |post| @all_results << post }
      @articles.each { |article| @all_results << article }
      @comments.each { |comment| @all_results << comment }
      @events.each { |event| @all_results << event }
      @tabs.each { |tab| @all_results << tab }
      
      @results = paginate @all_results
      
      if @all_results.empty? # notifies user when no results are found
        @no_results = translate("No results were found for") + " '#{@query}'"
      end
    else
      @no_results = translate "Empty search."
    end
    @advert = Article.local_advert(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "hashtags_search", nil, params[:query])
  end
end
