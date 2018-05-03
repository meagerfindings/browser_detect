# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :employee_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in(user_attribute)
    logged_in = false
    if user_attribute.is_a?(String)
      logged_in = true if current_user&.email == user_attribute
      logged_in = true if current_user&.id == user_attribute
    elsif user_attribute.is_a?(Integer)
      logged_in = true if current_user&.id == user_attribute
    end
    logged_in
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def employee_user
    @employee_user = false
    @employee_user = true if session[:user_id] && User&.find(session[:user_id])&.employee
  end

  def require_employee_user
    redirect_to '/' unless employee_user
  end
end
