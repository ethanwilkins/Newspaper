class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
  end
  
  def search
    if params[:query]
      @tags = if params[:query].include? "#"
                Hashtag.tagged(params[:query].downcase)
              else
                Hashtag.tagged("#" + params[:query].downcase)
              end
      if @tags.empty?
        @no_results = "No results were found."
      end
    end
  end
end
