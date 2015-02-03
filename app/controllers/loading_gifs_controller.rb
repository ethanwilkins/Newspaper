class LoadingGifsController < ApplicationController
  def index
    @current = LoadingGif.default ? LoadingGif.default : "loading.gif"
    @loading_gif = LoadingGif.new
  end
  
  def new
    @loading_gif = LoadingGif.new
  end
  
  def create
    @loading_gif = LoadingGif.new(params[:loading_gif].permit(:image))
    @loading_gif.user_id = params[:user_id]
    
    if params[:subtab_id]
      @loading_gif.subtab_id = params[:subtab_id]
    elsif params[:tab_id]
      @loading_gif.tab_id = params[:tab_id]
    end
    
    if @loading_gif.save
      log_action("loading_gifs_create", @loading_gif.id)
      if @loading_gif.user
        redirect_to user_path(@loading_gif.user.name)
      elsif @loading_gif.tab
        redirect_to tab_path(@loading_gif.tab)
      elsif @loading_gif.subtab
        redirect_to tab_subtab_path(@loading_gif.subtab.tab, @loading_gif.subtab)
      else
        redirect_to :back
      end
    else
      flash[:error] = translate("Invalid input")
      log_action("banners_create_fail")
      redirect_to :back
    end
  end
  
  def edit
    @loading_gif = LoadingGif.find_by_id(params[:id])
  end
  
  def update
    @loading_gif = LoadingGif.find_by_id(params[:id])
    if @loading_gif.update(params[:banner].permit(:image))
      log_action("loading_gifs_update", @loading_gif.id)
    else
      log_action("loading_gifs_update_fail", @loading_gif.id)
    end
    redirect_to :back
  end
  
  def destroy
    
  end
end
