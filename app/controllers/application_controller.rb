class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :translate, :page_size, :reset_page, :paginate, :get_item, :chosen_one,
    :master?, :admin?, :privileged?, :log_action, :new_search, :save_search, :english?, :writer?,
    :build_tab_feed_data, :build_search_results, :mobile?, :browser, :language

  private
  
  def new_search(query)
    search = Search.new_search(query, current_user)
    session[:search_id] = search.id
  end
  
  def save_search(chosen_result)
    if session[:search_id]
      Search.save_search(session[:search_id], chosen_result)
      session[:search_id] = nil
    end
  end
  
  def log_action(action="visit", item_id=nil, data_string=nil, item_type=nil)
    Activity.log_action(current_user, request.remote_ip.to_s,
      action, item_id, data_string, item_type, browser, mobile?)
  end
  
  def paginate(items, _page_size=page_size)
    return items.reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * _page_size).
      # only shows first several posts of resulting array
      first(_page_size)
  end

  def page_size
    @page_size = 10
  end
  
  def reset_page
    # resets back to top
    unless session[:more]
      session[:page] = nil
    end
  end
  
  def language(text)
  	wl = WhatLanguage.new(:english, :spanish)
  	return wl.language(text)
  end
  
  def translate(english)
    if english?
      spanish = nil
    else
      spanish = Translation.site_english(english)
    end
    if spanish.present? and not english?
    	return spanish.last.spanish
    elsif english? or privileged?
    	return english
    else
    	return " "
    end
  end
  
  def english?
    (current_user and current_user.english) or (request.host.to_s.include? "elhero.com" and \
      not (current_user and not current_user.english))
  end
  
  # returns a non-nil item from an array
  def chosen_one(items)
    for item in items
      return item if item
    end
  end
  
  def get_item(item_class, item_id)
    case item_class
      when "User"
        session[:user_id] = item_id
        return User.find_by_name item_id
      when "Post"
        session[:post_id] = item_id
        return Post.find_by_id item_id
      when "Article"
        session[:article_id] = item_id
        return Article.find_by_id item_id
      when "Comment"
        session[:comment_id] = item_id
        return Comment.find_by_id item_id
      when "Event"
        session[:event_id] = item_id
        return Event.find_by_id item_id
      when "Tab"
        session[:tab_id] = item_id
        return Tab.find_by_id item_id
    end
  end
  
  def build_search_results
    # saves in session for pages
    session[:query] = params[:query]
    if session[:query].present?
      @query = session[:query]
      new_search @query
      
      # scans all item texts for query
      @users = Search.users @query
      @posts = Search.posts @query
      @articles = Search.articles @query
      @comments = Search.comments @query
      @events = Search.events @query
      @tabs = Search.tabs @query

      # one array to rule them all
      @all_results = [] # collects results into one array
      @users.each { |user| @all_results << user }
      @posts.each { |post| @all_results << post }
      @articles.each { |article| @all_results << article }
      @comments.each { |comment| @all_results << comment }
      @events.each { |event| @all_results << event }
      @tabs.each { |tab| @all_results << tab }
      
      # sorts results by rank
      @all_results.sort_by! &:last
      
      # checks if any results were found
      if @all_results.empty? # notifies user when no results are found
        @no_results = translate("No results were found for") + " '#{@query}'"
      end
    else
      @all_results = Search.recent(current_user).reverse
      @recent = true
    end
    
    # paginates all results as results
    @results = paginate @all_results
    @all_items = @all_results
    @items = @results
  end
  
  # builds data for tab inside the page
  # controller to be rendered through javascript
  def build_tab_feed_data(tab)
    @tab = tab
    @advert = Article.local_advert(current_user)
    @posts = @tab.posts
    @all_items = @posts + @tab.funnel_tagged
    @all_items += @tab.approved_articles if @tab.approved_articles.present?
    @all_items += @tab.events if @tab.events.present?
    @all_items += @tab.polls if @tab.polls.present?
    @all_items.sort_by! &:created_at
    
    # popularity feature brings liked posts to top
    if @tab.features.exists? action: "popularity_float" \
      and not @tab.features.exists? action: "list_format"
      @all_items.sort_by! { |item| item.score }
    end
    
    # alphabetize for list format feature
    if @tab.features.exists? action: "list_format"
      @all_items.delete_if { |item| not defined? item.title \
        or item.title.nil? or item.title.empty? }.
        sort_by! { |item| item.title }
      @all_items.reverse!
    end
    
    # remove all non articles for articles features
    if @tab.features.exists? action: "articles"
    	@all_items.delete_if { |item| item.class.to_s != "Article" }
    end
    
    @items = paginate @all_items
  end
  
  def writer?
    return true if current_user.writer or privileged?
  end
  
  def privileged?
    return true if admin? or master?
  end
  
  def master?
    return true if current_user and current_user.master
  end
  
  def admin?
    return true if current_user and current_user.admin and current_user.group
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def mobile?
    browser.mobile? or browser.tablet?
  end
  
  def browser
    Browser.new(:ua => request.env['HTTP_USER_AGENT'].to_s, :accept_language => "en-us")
  end
end
