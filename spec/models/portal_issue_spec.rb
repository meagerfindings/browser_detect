# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortalIssue, type: :model do
  describe 'validation' do
    let(:portal) { Portal.last }

    before(:each) do
      temp_portal = Portal.new(name: 'Browser', current: rand(300))
      temp_portal.save
    end

    it 'belongs to portal' do
      issue = portal.portal_issues.new(name: 'name', description: 'description')
      expect(issue.save).to be_truthy
      expect(portal.portal_issues.last).to eq(issue)
    end

    it 'is invalid without a name' do
      issue = portal.portal_issues.new(name: '', description: 'description')
      expect(issue.save).to be_falsey
    end

    it 'is valid with a name' do
      issue = portal.portal_issues.new(name: 'name', description: 'description')
      expect(issue.save).to be_truthy
    end

    it 'is invalid without a description' do
      issue = portal.portal_issues.new(name: 'name', description: '')
      expect(issue.save).to be_falsey
    end

    it 'is valid with a description' do
      issue = portal.portal_issues.new(name: 'name', description: 'description')
      expect(issue.save).to be_truthy
    end

    it 'is invalid without a description longer than 5 chars' do
      issue = portal.portal_issues.new(name: 'name', description: '0123')
      expect(issue.save).to be_falsey
    end

    it 'is valid with a description longer than 5 chars' do
      issue = portal.portal_issues.new(name: 'name', description: '01234')
      expect(issue.save).to be_truthy
    end
  end
end
