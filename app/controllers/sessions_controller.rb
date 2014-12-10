class SessionsController < ApplicationController
  def new
    Activity.log_action(current_user, request.remote_ip.to_s, "sessions_new")
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      user.update ip: request.remote_ip.to_s
      user.update_token if user.auth_token.nil?
      cookies.permanent[:auth_token] = user.auth_token
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create")
      user.update zip_code: Activity.where(user_id: user.id).last.zip_code if \
        user.zip_code.nil? and Activity.where(user_id: user.id).last.zip_code.present?
      
      if request.host.to_s.include? "elhero.com"
        user.update english: true
      elsif request.host.to_s.include? "elheroe.net"
        user.update english: false
      end
      
      if Feature.page_jump(current_user)
        redirect_to tab_path(Feature.page_jump(current_user))
      else
        redirect_to root_url
      end
    else
      flash[:error] = translate "Invalid email or password"
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create_fail")
      redirect_to :back
    end
  end

  def destroy
    if current_user
      current_user.update_token
      cookies.delete(:auth_token)
    end
    flash[:notice] = translate("Log out successful.")
    Activity.log_action(current_user, request.remote_ip.to_s, "sessions_destroy")
    redirect_to root_url
  end
end
