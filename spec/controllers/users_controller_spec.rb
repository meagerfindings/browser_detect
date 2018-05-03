# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include UserAuth

  let(:users) { User.all }
  let(:user) { User.last }

  before(:each) do
    temp_user = User.new(email: "#{rand(2000)}@email.com",
                         password: 'password',
                         password_confirmation: 'password',
                         employee: false,
                         email_confirmed: true,
                         first_name: 'Guybrush',
                         last_name: 'Threepwood')
    temp_user.save

    temp_visit = Visitor.new(email: "#{rand(2000)}@email.com")
    temp_visit.save
  end

  describe 'Get Index' do
    it 'redirects home if not logged in' do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end

    it 'redirects home if logged in user not employee' do
      user_login
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end

    it 'gives status 200 if employee' do
      employee_login

      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders index for employee' do
      employee_login
      get :index
      expect(response).to render_template('index')
    end

    it 'returns the entire list of users' do
      employee_login
      get :index
      expect(assigns(:users)).to eq(users)
    end
  end

  describe 'Get New' do
    it 'renders New template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'reroutes logged in users home' do
      user_login
      get :new
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end

    it 'reroutes employee to home' do
      employee_login
      get :new
      expect(response).to have_http_status(302)
      expect(response).to redirect_to root_url
    end
  end

  describe 'Create User' do
    it 'redirects to login if success' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = "Do you have a reservation?#{rand(50_000)}"

      put :create, params: { user: { email: email,
                                     password: password,
                                     password_confirmation: password,
                                     first_name: 'Guybrush',
                                     last_name: 'Threepwood' } }
      expect(response).to redirect_to login_url
    end

    it 'creates user' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = "Do you have a reservation?#{rand(50_000)}"

      put :create, params: { user: { email: email,
                                     password: password,
                                     password_confirmation: password,
                                     first_name: 'Guybrush',
                                     last_name: 'Threepwood' } }
      expect(response).to redirect_to login_url
      expect(assigns(:user)).to eq(user)
    end

    it 'renders signup if errors' do
      put :create, params: { user: { email: '',
                                     password: '',
                                     password_confirmation: '',
                                     first_name: '',
                                     last_name: '' } }
      expect(response).to redirect_to signup_url
    end
  end

  describe 'Show' do
    it 'renders user page if same user logged in' do
      user_login
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it 'renders user page if employee logged in' do
      employee_login
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end

    it 'redirects home if a different user logged in' do
      user_login
      get :show, params: { id: User.first.id }
      expect(response).to redirect_to root_url
    end

    it 'redirects home if not logged in' do
      get :show, params: { id: user.id }
      expect(response).to redirect_to root_url
    end
  end

  describe 'Confirm Email' do
    it 'confirms user' do
      token = 'harbinger'
      temp_user = User.new(email: "#{rand(2000)}@email.com",
                           password: 'password',
                           password_confirmation: 'password',
                           employee: false,
                           email_confirmed: false,
                           first_name: 'Guybrush',
                           last_name: 'Threepwood',
                           confirm_token: token)
      temp_user.save

      get :confirm_email, params: { id: token }
      expect(assigns(:user).email_confirmed).to eq(true)
    end

    it 'redirects to login on success' do
      token = 'harbinger'
      temp_user = User.new(email: "#{rand(2000)}@email.com",
                           password: 'password',
                           password_confirmation: 'password',
                           employee: false,
                           email_confirmed: false,
                           first_name: 'Guybrush',
                           last_name: 'Threepwood',
                           confirm_token: token)
      temp_user.save

      get :confirm_email, params: { id: token }
      expect(response).to redirect_to login_url
      expect(response).to have_http_status(302)
    end

    it 'redirects to signup on failure' do
      get :confirm_email, params: { id: 'non-existent-token' }
      expect(response).to redirect_to signup_url
      expect(response).to have_http_status(302)
    end
  end

  describe 'Destroy' do
    it 'destroys user visits if user is logged in user' do
      user_login

      5.times do
        temp_visit = Visitor.new(email: user.email)
        temp_visit.save
      end

      email = user.email

      start_count = 0

      Visitor.all.each do |visitor|
        start_count += 1 if visitor.email == email
      end
      delete :destroy, params: { id: user.id }

      end_count = 0

      Visitor.all.each do |visitor|
        end_count += 1 if visitor.email == email
      end

      expect(end_count).to_not eq(start_count)
    end

    it 'destroys user visits if user employee' do
      employee_login

      5.times do
        temp_visit = Visitor.new(email: User.first.email)
        temp_visit.save
      end

      email = User.first.email

      start_count = 0

      Visitor.all.each do |visitor|
        start_count += 1 if visitor.email == email
      end
      delete :destroy, params: { id: User.first.id }

      end_count = 0

      Visitor.all.each do |visitor|
        end_count += 1 if visitor.email == email
      end

      expect(end_count).to_not eq(start_count)
    end

    it 'destroys user if user employee' do
      employee_login

      start_count = users.count

      delete :destroy, params: { id: User.first.id }
      expect(users.count).to_not eq(start_count)
    end

    it 'destroys user if user logged in user' do
      user_login

      start_count = users.count

      delete :destroy, params: { id: user.id }
      expect(users.count).to_not eq(start_count)
    end

    it 'redirects to users index if employee' do
      employee_login
      delete :destroy, params: { id: User.first.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to users_path
    end

    it 'redirects to logout if not employee' do
      user_login

      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to logout_path
    end
  end
end
