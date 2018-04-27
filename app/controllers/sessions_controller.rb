# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by_email(params[:session][:email])

    if @user&.authenticate(params[:session][:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        redirect_to '/'
        # redirect_back @user
      else
        flash[:error] = 'Please activate your account by following the instructions in the account confirmation email you received.'
        redirect_to login_url
      end
    else
      flash[:error] = 'Invalid email or password.'
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
