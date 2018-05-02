# frozen_string_literal: true

class User < ApplicationRecord
  default_scope -> { order("created_at ASC") }

  has_secure_password

  before_create { generate_token(:auth_token) }
  before_create :confirmation_token

  # Regex Source: https://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, uniqueness: true

  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :first_name, presence: true
  validates :last_name, presence: true

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def email_activate
    update_columns(email_confirmed: true, confirm_token: nil)
    save(valdiate: false)
  end

  def send_password_reset
    self.update_columns(password_reset_token: SecureRandom.urlsafe_base64,
                        password_reset_sent_at: Time.zone.now)
    self.save(valdiate: false)
    UserMailer.password_reset(self).deliver
  end

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
