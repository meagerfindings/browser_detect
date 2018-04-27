class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  helper_method :employee_user

  def employee_user
    @employee_user ||= true if session[:user_id] && User.find(session[:user_id]).employee
  end

  def require_employee_user
    redirect_to '/' unless employee_user
  end

end
