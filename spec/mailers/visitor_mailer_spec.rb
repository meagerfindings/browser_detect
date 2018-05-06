# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitorMailer, type: :mailer do
  let(:visitor) { Visitor.last }
  let(:mail) { VisitorMailer.with(visitor: visitor).share_information_email }

  it 'renders the headers' do
    temp_vis = Visitor.new(email: 'to@example.org',
                           browser: 'FireFox',
                           version: '59',
                           comp_mode: false,
                           os: 'Chrome OS')
    temp_vis.save

    expect(mail.subject).to eq("BrowserDetect: #{visitor.email}")
    expect(mail.to).to eq([ENV['EMAIL_TARGET']])
    expect(mail.from).to eq([ENV['EMAIL_USERNAME']])
  end
end
