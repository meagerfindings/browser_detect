# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    user&.send_password_reset
    redirect_to login_url, notice: 'Email sent with password reset instructions.'
  end

  def edit
    if User&.find_by_password_reset_token(params[:id])
      @user = User.find_by_password_reset_token!(params[:id])
    else
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    end
  end

  def update
    @user = User&.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 30.minutes.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    elsif @user.update_attributes(user_params)
      @user.update_columns(password_reset_token: nil,
                           password_reset_sent_at: nil)
      @user.save
      redirect_to login_url, notice: 'Password has been reset successfully. Please login using new password.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
