# frozen_string_literal: true

module UserAuth
  def employee_login
    email = "#{rand(2_000)}_EMPLOYEE_#{ENV['EMPLOYEE_EMAIL_DOMAIN']}"
    password = ENV['TEST_PASS']
    employee = User.create(email: email,
                           password: password,
                           password_confirmation: password,
                           employee: true,
                           email_confirmed: true,
                           first_name: 'Employee',
                           last_name: 'Extraordinaire')
    employee.save(validation: false)
    session[:user_id] = employee.id
  end

  def user_login
    email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
    password = ENV['TEST_PASS']
    user = User.create(email: email,
                       password: password,
                       password_confirmation: password,
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
    user.save
    session[:user_id] = user.id
  end
end
