class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
    log_action("hashtags_tagged")
  end
end
