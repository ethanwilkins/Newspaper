class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
    Activity.log_action(current_user, request.remote_ip.to_s, "hashtags_tagged")
  end
  
  def search
    if params[:query]
      @tags = if params[:query].include? "#"
                Hashtag.tagged(params[:query].downcase)
              else
                Hashtag.tagged("#" + params[:query].downcase)
              end
      if @tags.empty?
        @no_results = translate("No results were found.")
      end
    end
    @advert = Article.local_advert(current_user)
    Activity.log_action(current_user, request.remote_ip.to_s, "hashtags_search", nil, params[:query])
  end
end
