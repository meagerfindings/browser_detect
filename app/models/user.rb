# frozen_string_literal: true

class User < ApplicationRecord
  before_create :confirmation_token
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i # Regex Source: https://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of
  validates :password, length: { minimum: 6 }

  has_secure_password

  def email_activate
    self.update_columns(email_confirmed: true, confirm_token: nil)
    save(valdiate: false)
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
