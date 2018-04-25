class VisitorMailer < ApplicationMailer
  def share_information_email
    @visitor = params[:visitor]
    VisitorMailer.with(visitor: @visitor).share_information_email.deliver_later
    # @url = "http://browser-detect.herokuapp.com/visitors/#{@visitor.id}"
    mail(to: 'mgreten@gmail.com',
         subject: 'BrowserDetect:Visitor information shared with you.')
  end
end
