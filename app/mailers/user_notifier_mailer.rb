class UserNotifierMailer < ApplicationMailer

  def send_signup_email(user)
      @user = user
      mail to: @user.email, subject: "会員登録が完了しました。"
  end

  def notify_user
      default to: -> { User.pluck(:email) }
      mail(subject: "everyday BOOKERS!yay!")
  end

end
