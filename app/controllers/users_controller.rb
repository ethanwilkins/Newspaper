class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user].permit(:name, :zip_code, :password))
    @user.name.downcase!
    
    if @user.save
      user = User.last
      session[:user_id] = user.id
      redirect_to root_url
    else
      render "new"
    end
  end
end
