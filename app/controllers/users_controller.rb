class UsersController < ApplicationController
  def create
    @user = User.new(params[:user].permit(:name, :password))
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
