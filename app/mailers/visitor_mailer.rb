class VisitorMailer < ApplicationMailer
  def share_information_email
    @visitor = params[:visitor]
    VisitorMailer.with(visitor: @visitor).share_information_email
    mail(to: ENV['EMAIL_TARGET'], subject: "BrowserDetect: #{@visitor.email}")
  end
end
