class PagesController < ApplicationController
  # :page is the page number for each feed
  def more
    if session[:page].nil? or session[:page] * page_size <= Activity.all.size
      if session[:page]
        session[:page] += 1
      else
        session[:page] = 1
      end
      session[:more] = :more
    end
    Activity.log_action(current_user, request.remote_ip.to_s, "pages_more")
    redirect_to :back
  end
  
  def back
    Activity.log_action(current_user, request.remote_ip.to_s, "pages_back")
    redirect_to :back
  end
end
