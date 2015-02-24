class PagesController < ApplicationController
  # :page is the page number for each feed
  
  def more
    # should replace activity size with the relevant items size
    if session[:page].nil? or session[:page] * page_size <= Activity.all.size
      if session[:page]
        session[:page] += 1
      else
        session[:page] = 1
      end
      build_feed_data
      log_action("pages_more")
    else
      log_action("pages_more_fail")
    end
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
    elsif params[:tabs]
      @tab_index_shown = true
      @all_items = Tab.approved
      @items = paginate @all_items
    elsif params[:user_id]
      @user_shown = true
      @user = User.find_by_name(params[:user_id])
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
    elsif params[:search]
      @search_shown = true
      build_search_results
    end
  end
end
