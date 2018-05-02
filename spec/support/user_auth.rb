# frozen_string_literal: true

module UserAuth
  def employee_login
    email = "#{rand(2_000)}_EMPLOYEE_#{ENV['EMPLOYEE_EMAIL_DOMAIN']}"
    password = "bumble bee tuna#{rand(50_000)}"
    employee = User.create(email: email,
                           password: password,
                           password_confirmation: password,
                           employee: true,
                           email_confirmed: true,
                           first_name: 'employee',
                           last_name: 'extraordinaire')
    employee.save(validation: false)
    session[:user_id] = employee.id
  end

  def user_login
    email = "#{rand(2_000)}_NON-EMPLOYEE_@browser_detect.com"
    password = "do you have a reservation?#{rand(50_000)}"
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password,
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'threepwood')
    user.save
    session[:user_id] = user.id
  end
end
