class TranslationsController < ApplicationController
  def index
    # resets back to top
    unless session[:more]
      session[:page] = nil
    end
    session[:more] = nil
    
    @translation = Translation.new
    @translations = Translation.all.reverse.
      # drops first several posts if :feed_page
      drop((session[:page] ? session[:page] : 0) * page_size).
      # only shows first several posts of resulting array
      first(page_size)
    Activity.log_action(current_user, request.remote_ip.to_s, "translations_index")
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def create
    @translation = Translation.new(params[:translation].permit(:english, :spanish))
    
    if @translation.save
      flash[:notice] = translate("Translation saved successfully.")
      Activity.log_action(current_user, request.remote_ip.to_s, "translations_create", @translation.id)
    else
      flash[:error] = translate("Translation could not be saved.")
      Activity.log_action(current_user, request.remote_ip.to_s, "translations_create_fail")
    end
    redirect_to :back
  end
  
  def destroy
    
  end
end
