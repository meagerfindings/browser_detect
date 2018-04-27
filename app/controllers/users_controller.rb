class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.first_name = @user.first_name.titleize
    @user.last_name = @user.last_name.titleize
    @user.email = @user.email.downcase
    @user.employee = true if @user.email.include? ENV['EMPLOYEE_EMAIL_DOMAIN']

    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :employee)
  end
end
