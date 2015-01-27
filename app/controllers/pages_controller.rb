class PagesController < ApplicationController
  # :page is the page number for each feed
  
  def more
    if session[:page].nil? or session[:page] * page_size <= Activity.all.size
      if session[:page]
        session[:page] += 1
      else
        session[:page] = 1
      end
    end
    build_feed_data
    log_action("pages_more")
  end
  
  def back
    log_action("pages_back")
    redirect_to :back
  end
  
  private
  
  def build_feed_data
    if params[:tab_id]
      @tab_shown = true
      tab = Tab.find_by_id(params[:tab_id])
      build_tab_feed_data(tab)
    elsif params[:user_id]
      @user_shown = true
      @user = User.find_by_id(params[:user_id])
      @all_items = @user.posts
      @items = paginate @user.posts
    elsif params[:notes]
      @notes_shown = true
      @all_items = current_user.notes
      @all_items.each do |note|
        note.update checked: true
      end
      @items = paginate @all_items
      @advert = Article.local_advert(current_user)
    end
  end
end
