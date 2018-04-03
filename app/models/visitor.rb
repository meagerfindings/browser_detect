class Visitor < ApplicationRecord
  validates :email, presence: true

  def self.add_attributes(user_agent)
    browser = Browser.new(user_agent)
    { browser: browser.name.to_s,
      version: browser.full_version.to_s,
      os: "#{browser.platform} #{browser.platform.version}",
      comp_mode: browser.compatibility_view? }
  end
end
