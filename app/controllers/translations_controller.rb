class TranslationsController < ApplicationController
  def requests
    reset_page
    @requests = paginate Translation.requests.reverse
    log_action("translations_requests")
  end
  
  def show
    @translation = Translation.find_by_id(params[:id])
    if @translation
      @comments = @translation.comments
      @new_comment = Comment.new
      log_action("translations_show")
    else
      log_action("translations_show_fail")
    end
  end
  
  def index
    reset_page
    @translation = Translation.new
    @translations = paginate Translation.translated
    log_action("translations_index")
  end
  
  def edit
    @translation = Translation.find(params[:id])
    log_action("translations_edit", @translation.id)
  end
  
  def update
    @translation = Translation.find(params[:id])
    @translation.user_id = params[:user_id]
    if @translation.update(params[:translation].permit(:english, :spanish))
      flash[:notice] = translate("The translation was successfully updated.")
      log_action("translations_update", @translation.id)
      redirect_to translations_path
    else
      flash[:error] = translate("Invalid input.")
      log_action("translations_update_fail", @translation.id)
      redirect_to :back
    end
  end
  
  def create
    @translation = Translation.new(params[:translation].permit(:english, :spanish, :request))
    @translation.user_id = params[:user_id]
    @translation.request = true \
      if @translation.english.empty? or @translation.spanish.empty?
    if @translation.save
      flash[:notice] = translate("Translation saved successfully.")
      log_action("translations_create", @translation.id)
    else
      flash[:error] = translate("Translation could not be saved.")
      log_action("translations_create_fail")
    end
    redirect_to :back
  end
  
  def destroy
    @translation = Translation.find_by_id(params[:id])
    if @translation.destroy
      flash[:notice] = translate("Translation successfully deleted.")
      log_action("translations_destroy")
      redirect_to translations_path
    else
      flash[:error] = translate("Translation could not be deleted.")
      log_action("translations_destroy_fail", @translation.id)
      redirect_to :back
    end
  end
end
