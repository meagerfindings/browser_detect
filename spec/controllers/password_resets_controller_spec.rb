# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { User.last }

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'PUT #create' do
    before(:each) do
      temp_user = User.new(email: "#{rand(2000)}@email.com",
                           password: 'passworD3333!',
                           password_confirmation: 'passworD3333!',
                           employee: false,
                           email_confirmed: true,
                           first_name: 'Guybrush',
                           last_name: 'Threepwood')
      temp_user.save
    end
    it 'redirects to the login url' do
      put :create, params: { email: user.email }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to login_url
    end
  end

  describe 'GET #edit' do
    before(:each) do
      temp_user = User.new(email: "#{rand(2000)}@email.com",
                           password: 'passworD3333!',
                           password_confirmation: 'passworD3333!',
                           employee: false,
                           email_confirmed: true,
                           first_name: 'Guybrush',
                           last_name: 'Threepwood',
                           password_reset_token: 'token',
                           password_reset_sent_at: Time.now)
      temp_user.save
    end

    it 'renders edit if token valid' do
      get :edit, params: { id: user.password_reset_token }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end

    it 'redirects to new password reset path if invalid token' do
      get :edit, params: { id: 'invalid token' }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_password_reset_path
    end

    describe 'POST #update' do
      before(:each) do
        email = "#{rand(2000)}@email.com"
        temp_user = User.new(email: email,
                             password: 'passworD3333!',
                             password_confirmation: 'passworD3333!',
                             employee: false,
                             email_confirmed: true,
                             first_name: 'Guybrush',
                             last_name: 'Threepwood',
                             password_reset_token: email,
                             password_reset_sent_at: Time.now)
        temp_user.save
      end

      it 'updates password if valid' do
        old_password_digest = user.password_digest
        new_password = 'Pas_sword1!4545454'
        post :update, params: { user: { password: new_password,
                                        password_confirmation: new_password },
                                id: user.password_reset_token }
        expect(assigns(:user).password_digest).to_not eq(old_password_digest)
      end

      it 'clears the password reset token if successful' do
        old_password_token = user.password_reset_token
        new_password = 'Pas_sword1!4545454'
        post :update, params: { user: { password: new_password,
                                        password_confirmation: new_password },
                                id: user.password_reset_token }
        expect(assigns(:user).password_reset_token).to_not eq(old_password_token)
        expect(assigns(:user).password_reset_token).to eq(nil)
      end

      it 'clears the password reset sent at time if successful' do
        sent_at = user.password_reset_sent_at
        new_password = 'Pas_sword1!4545454'
        post :update, params: { user: { password: new_password,
                                        password_confirmation: new_password },
                                id: user.password_reset_token }
        expect(assigns(:user).password_reset_sent_at).to_not eq(sent_at)
        expect(assigns(:user).password_reset_sent_at).to eq(nil)
      end

      it 'redirects to login if successful' do
        new_password = 'Pas_sword1!4545454'
        post :update, params: { user: { password: new_password,
                                        password_confirmation: new_password },
                                id: user.password_reset_token }

        expect(response).to have_http_status(302)
        expect(response).to redirect_to login_url
      end

      it 'redirects to new_password if token > 30 minutes old' do
        user.password_reset_sent_at = Time.now - 800.hour
        user.save!(validate: false)

        new_password = 'Pas_sword1!4545454'
        put :update, params: { user: { password: new_password,
                                       password_confirmation: new_password },
                               id: User.last.password_reset_token }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_password_reset_path
      end

      it 'does not change to password if token > 30 minutes old' do
        user.password_reset_sent_at = Time.now - 800.hour
        user.save!(validate: false)

        old_password_digest = user.password_digest
        new_password = 'Pas_sword1!4545454'
        post :update, params: { user: { password: new_password,
                                        password_confirmation: new_password },
                                id: user.password_reset_token }
        expect(assigns(:user).password_digest).to eq(old_password_digest)
        expect(assigns(:user).password_digest).to_not eq(nil)
        expect(assigns(:user).password_reset_token).to_not eq(nil)
      end

      it 'renders edit if passwords do not match' do
        old_password_digest = user.password_digest
        new_password = 'Pas_sword1!4545454'

        post :update, params: { user: { password: new_password,
                                        password_confirmation: 'NOT the same235423534!' },
                                id: user.password_reset_token }

        expect(user.password_digest).to eq(old_password_digest)
        expect(assigns(:user).password_digest).to_not eq(nil)
        expect(assigns(:user).password_reset_token).to_not eq(nil)
        expect(response).to render_template(:edit)
      end

      it 'renders edit if password confirmation missing' do
        old_password_digest = user.password_digest
        new_password = 'Pas_sword1!4545454'

        post :update, params: { user: { password: new_password },
                                id: user.password_reset_token }

        expect(user.password_digest).to eq(old_password_digest)
        expect(assigns(:user).password_digest).to_not eq(nil)
        expect(assigns(:user).password_reset_token).to_not eq(nil)
        expect(response).to render_template(:edit)
      end
    end
  end
end
