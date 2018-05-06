# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include UserAuth
  let(:user) { User.last }

  describe 'PUT #Create' do
    before(:each) do
      temp_user = User.new(email: "#{rand(2000)}@email.com",
                           password: ENV['TEST_PASS'],
                           password_confirmation: ENV['TEST_PASS'],
                           employee: false,
                           email_confirmed: true,
                           first_name: 'Guybrush',
                           last_name: 'Threepwood')
      temp_user.save
    end

    it 'redirects to login if invalid email' do
      put :create, params: { session: { email: 'wrong email',
                                        password: ENV['TEST_PASS'] } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_url
    end

    it 'redirects to login if invalid password' do
      put :create, params: { session: { email: user.email,
                                        password: 'wrong password' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_url
    end

    it 'redirects to login if email not confirmed' do
      user.email_confirmed = false
      user.save!(validate: false)

      put :create, params: { session: { email: user.email,
                                        password: ENV['TEST_PASS'] } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_url
    end

    it 'redirects to the root if successful' do
      put :create, params: { session: { email: user.email,
                                        password: ENV['TEST_PASS'] } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end

    it 'sets the session[:user_id] to the user.id if successful' do
      put :create, params: { session: { email: user.email,
                                        password: ENV['TEST_PASS'] } }
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe 'delete #Destroy' do
    before(:each) do
      user_login
    end

    it 'sets the session[:user_id] to nil' do
      session_id = session[:user_id]
      delete :destroy
      expect(session_id).to_not eq(session[:user_id])
      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects to the root' do
      delete :destroy
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end
  end
end
