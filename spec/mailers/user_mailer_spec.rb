# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'password_reset' do
    let(:user) { User.last }
    let(:mail) { UserMailer.password_reset(user) }

    before(:each) do
      temp_user = User.new(email:                 'to@example.org',
                           password:              ENV['TEST_PASS'],
                           password_confirmation: ENV['TEST_PASS'],
                           employee:              false,
                           email_confirmed:       true,
                           first_name:            'Guybrush',
                           last_name:             'Threepwood',
                           password_reset_token:  'token')
      temp_user.save

      temp_visit = Visitor.new(email: "#{rand(2000)}@email.com")
      temp_visit.save
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Password Reset')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq([ENV['EMAIL_USERNAME']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("To reset your password click the URL below.\r\n\r\nhttp://localhost:3000/password_resets/token/edit\r\n\r\nIf you did not request your password to be reset please ignore this email and your password will stay as it is.")
    end
  end

  describe 'password_reset' do
    let(:user) { User.last }
    let(:mail) { UserMailer.registration_confirmation(user) }

    before(:each) do
      temp_user = User.new(email:                 'to@example.org',
                           password:              ENV['TEST_PASS'],
                           password_confirmation: ENV['TEST_PASS'],
                           employee:              false,
                           email_confirmed:       false,
                           first_name:            'Guybrush',
                           last_name:             'Threepwood',
                           confirm_token:  "token#{rand(200)}")
      temp_user.save
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('BrowserDetect Registration Confirmation')
      expect(mail.to).to eq(["#{user.email}"])
      expect(mail.from).to eq([ENV['EMAIL_USERNAME']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("Hello #{user.first_name},\r\n\r\nThank you for registering your account with BrowserDetect. To confirm your registration, please click this URL: http://localhost:3000/users/#{user.confirm_token}/confirm_email\r\n\r\nHave a wonderful day!\r\n\r\nWith best regards,\r\nThe BrowserDetect Team")
    end
  end
end
