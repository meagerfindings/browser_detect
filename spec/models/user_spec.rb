# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with an email address' do
      user = User.new(email: 'test@test.com',
                      password: ENV['TEST_PASS'],
                      password_confirmation: ENV['TEST_PASS'],
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')
      expect(user.save).to be_truthy
    end

    it 'is not valid without an email address' do
      user = User.new(email: '',
                      password: ENV['TEST_PASS'],
                      password_confirmation: ENV['TEST_PASS'],
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')
      expect(user.save).to be_falsey
    end

    it 'is not valid without a valid email address' do
      user = User.new(email: 'test',
                      password: ENV['TEST_PASS'],
                      password_confirmation: ENV['TEST_PASS'],
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')
      expect(user.save).to be_falsey

      user2 = User.new(email: 'test@.com',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user2.save).to be_falsey

      user3 = User.new(email: '@.gmail.com',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user3.save).to be_falsey

      user4 = User.new(email: 'j@gmailcom',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user4.save).to be_falsey

      user5 = User.new(email: 'j@.gmail.net',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user5.save).to be_falsey
    end

    it 'is valid with valid email addresses' do
      user1 = User.new(email: 'mat@gmail.net',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user1.save).to be_truthy

      user2 = User.new(email: 'mat@gmail.com',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user2.save).to be_truthy

      user3 = User.new(email: 'mat.greten@gmail.com',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user3.save).to be_truthy

      user4 = User.new(email: 'mat+.greten@gmail.com',
                       password: ENV['TEST_PASS'],
                       password_confirmation: ENV['TEST_PASS'],
                       employee: false,
                       email_confirmed: true,
                       first_name: 'Guybrush',
                       last_name: 'Threepwood')
      expect(user4.save).to be_truthy
    end

    it 'requires a number in password' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'NoNumbersss?'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'requires an uppercase letter in password' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'nouppercaseletters?12'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'requires a lower letter in password' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'NOLOWERCASELETTERS?12'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'requires a special character in password' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'NoSpecialCharacters12'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'requires 12 characters in password' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = '0nly11Char?'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'has a valid password if > 12 char, Uppercase, Lowercase, and symbol' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'This.1Password.Meets.Requirements!?'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Guybrush',
                      last_name: 'Threepwood')

      expect(user.save).to be_truthy
    end

    it 'has a first name' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'This.1Password.Meets.Requirements!?'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: '',
                      last_name: 'Threepwood')

      expect(user.save).to be_falsey
    end

    it 'has a last name' do
      email = "#{rand(2_000)}_NON-EMPLOYEE_@browserdetect.com"
      password = 'This.1Password.Meets.Requirements!?'

      user = User.new(email: email,
                      password: password,
                      password_confirmation: password,
                      employee: false,
                      email_confirmed: true,
                      first_name: 'Threepwood',
                      last_name: '')

      expect(user.save).to be_falsey
    end
  end
end
