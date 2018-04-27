class UserMailer < ActionMailer::Base
  default from: ENV['EMAIL_USERNAME']

  def registration_confirmation(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>",
         subject: 'BrowserDetect Registration Confirmation')
  end
end