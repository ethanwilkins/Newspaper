class PagesController < ApplicationController
  # :page is the page number for each feed
  def more
    if session[:page].nil? or session[:page] * page_size <= Post.all.size
      if session[:page]
        session[:page] += 1
      else
        session[:page] = 1
      end
      session[:more] = :more
    end
    redirect_to :back
  end
  
  def back
    redirect_to :back
  end
end
