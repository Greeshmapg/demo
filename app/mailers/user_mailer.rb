class UserMailer < ApplicationMailer

  default from: "from@example.com"

  def user_activation(user,password)
    @user = user
    @password=password
    mail to: @user.email, subject: 'Account activation'
  end

  def invite_user(user)
    @user = user
    mail to: @user.email, subject: 'Team Invitation'
  end

end
