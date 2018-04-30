module UserAuth
  def employee_login
    email = "#{rand(2_000)}_EMPLOYEE_#{ENV['EMPLOYEE_EMAIL_DOMAIN']}"
    employee = User.create(email: email,
                           password: "bumble bee tuna#{rand(50_000)}",
                           employee: true,
                           email_confirmed: true)
    employee.save
    session[:user_id] = employee.id
  end

  def user_login
    email = "#{rand(2_000)}_NON-EMPLOYEE_@browser_detect.com"
    employee = User.create(email: email,
                           password: "bumble bee tuna#{rand(50_000)}",
                           employee: false,
                           email_confirmed: true)
    employee.save
    session[:user_id] = employee.id
  end
end