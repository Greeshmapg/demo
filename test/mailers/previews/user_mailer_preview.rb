# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_activation
  def user_activation
    @password="123456"
    UserMailer.user_activation(User.last,@password)
  end

  def invite_user
    UserMailer.user_activation(User.last)
  end


end
