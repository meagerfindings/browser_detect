# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersHelper

  def index
    if employee_user
      @users = User.all
      @page_title = 'All Registered Users'
    else
      redirect_to root_path
    end
  end

  def new
    if !session[:user_id].nil?
      flash[:error] = 'You already have an account. Sign out to create a new account if desired.'
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @user.first_name = @user.first_name.titleize
    @user.last_name = @user.last_name.titleize
    @user.email = @user.email.downcase
    @user.employee = true if @user.email.include? ENV['EMPLOYEE_EMAIL_DOMAIN']

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please activate your account by following the instructions in the account confirmation email that was just sent to: #{@user.email}."
      redirect_to login_url
    else
      @user.errors.full_messages.each do |msg|
        flash[:error] = msg
      end
      redirect_to signup_url
    end
  end

  def show
    user = User.find_by_id(params[:id])

    if logged_in(user.id) || employee_user
      @user = User.find_by_id(params[:id])
    else
      redirect_to root_url
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:success] = 'Welcome to BrowserDetect. Your email has been confirmed. Please sign in to continue.'
      redirect_to login_url
    else
      flash[:error] = 'Sorry. Please try to create a new account.'
      redirect_to signup_path
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])

    if logged_in(@user.id) || employee_user
      find_user_visits(@user.email).each do |_key, visit|
        visit.destroy
      end

      flash[:success] = "User profile and all visits for #{@user.email} deleted."
      @user.destroy
    end

    if session[:user_id] != @user.id
      redirect_to users_path if employee_user
    else
      redirect_to logout_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :password_confirmation,
                                 :employee)
  end
end
