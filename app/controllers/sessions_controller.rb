class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:name], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:error] = "Invalid email or password"
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
