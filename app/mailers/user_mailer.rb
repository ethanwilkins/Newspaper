class UserMailer < ActionMailer::Base
  default from: "www.elheroe.net"
  
  def welcome_user(user)
    @user = user
    @url = "www.elheroe.net"
    mail(to: @user.email, subject: "Welcome to El Heroe!")
  end
  
  def user_won(user)
    @user = user
    mail(to: "ethanforrestwilkins@gmail.com", subject: "A user won a prize.")
  end
end
