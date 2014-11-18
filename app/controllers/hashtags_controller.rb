class HashtagsController < ApplicationController
  def tagged
    @tags = Hashtag.tagged(params[:tag]) if params[:tag]
    Activity.log_action(current_user, request.remote_ip.to_s, "hashtags_tagged")
  end
end
