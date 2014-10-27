class SessionsController < ApplicationController
  def new
    Activity.log_action(current_user, request.remote_ip.to_s, "sessions_new")
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create")
      redirect_to root_url
    else
      flash[:error] = translate "Invalid email or password"
      Activity.log_action(current_user, request.remote_ip.to_s, "sessions_create_fail")
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    Activity.log_action(current_user, request.remote_ip.to_s, "sessions_destroy")
    redirect_to root_url
  end
end
