class Visitor < ApplicationRecord
  default_scope -> { order("created_at ASC") }
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i # Regex Source: https://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of

  def self.add_attributes(user_agent)
    browser = Browser.new(user_agent)
    { browser: browser.name.to_s.titleize,
      version: browser.full_version.to_s,
      os: "#{browser.platform} #{browser.platform.version}".titleize,
      comp_mode: browser.compatibility_view? }
  end
end
