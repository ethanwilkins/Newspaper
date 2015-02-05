class SearchController < ApplicationController
  def search
    reset_page
    build_search_results
    @advert = Article.local_advert(current_user)
    log_action("hashtags_search", nil, params[:query])
  end
end
