# frozen_string_literal: true

module VisitorsHelper
  @current_version = 0
  @issues = {}
  @portal_issues = {}

  def browser_issue_check(browser, version)
    browser_name = browser.to_s.strip
    version_number = version.to_i

    find_browser_information(browser_name, version_number)
  end

  def find_browser_information(browser, version_int)
    portals = Portal.all
    portal_id = ''

    portals.each do |portal|
      portal_id = portal.id if portal.name == browser
    end

    if portal_id.blank?
      temp_portal = Portal.new(name: browser, current: 0)
      temp_portal.save

      portals = Portal.all

      portals.each do |portal|
        portal_id = portal.id if portal.name == browser
      end
    end

    portal = Portal.find(portal_id)
    @current_version = portal&.current

    @portal_issues = {}
    portal&.portal_issues&.each do |value|
      @portal_issues[value.id] = { name: value.name, description: value.description }
    end

    version_id = ''

    portal&.versions&.each do |temp_version|
      version_id = temp_version.id if temp_version.number == version_int
    end

    @issues = {}

    if version_id.blank?
      temp_version = portal.versions.new(number: version_int)
      temp_version.save
      @issues
    else
      version = portal.versions.find(version_id)

      version&.issues&.each do |issue|
        @issues[issue.id] = { name: issue.name, description: issue.description }
      end
    end
  end

  def outdated(user_version)
    outdated = false
    unless @current_version.zero?
      acceptable = @current_version - 2
      outdated = true if user_version.to_i < acceptable
    end
    outdated
  end
end
