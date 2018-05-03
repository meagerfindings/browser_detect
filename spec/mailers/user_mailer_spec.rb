# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'password_reset' do
    let(:user) { User.last}
    let(:mail) { UserMailer.password_reset(user) }

    before(:each) do
      temp_user = User.new(email:                 'to@example.org',
                           password:              'password',
                           password_confirmation: 'password',
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
      expect(mail.from).to eq([ENV['EMAIL_TARGET']])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("To reset your password click the URL below.\r\n\r\nhttp://localhost:3000/password_resets/token/edit\r\n\r\nIf you did not request your password to be reset please ignore this email and your password will stay as it is.")
    end
  end
end
