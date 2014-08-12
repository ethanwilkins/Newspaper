class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def user_won(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
