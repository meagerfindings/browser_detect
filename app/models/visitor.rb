class Visitor < ApplicationRecord
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i # Regex Source: https://apidock.com/rails/ActiveModel/Validations/ClassMethods/validates_format_of

  def self.add_attributes(user_agent)
    browser = Browser.new(user_agent)
    { browser: browser.name.to_s,
      version: browser.full_version.to_s,
      os: "#{browser.platform} #{browser.platform.version}",
      comp_mode: browser.compatibility_view? }
  end
end
