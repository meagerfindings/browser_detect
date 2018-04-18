require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'validations' do
    it 'is valid with a version parent' do
      version = Version.new(number: 2)
      issue = version.issues.new(name: 'Version Name', description: 'Did you?')
      expect(issue.save).to be_truthy
    end

    it 'is invalid without a name' do
      version = Version.new(number: 3)
      issue = version.issues.new(description: 'nice name, no name')
      expect(issue.save).to be_falsey
    end

    it 'is invalid without a description' do
      version = Version.new(number: 4)
      issue = version.issues.new(name: 'no description')
      expect(issue.save).to be_falsey
    end

    it 'is valid with a name and description' do
      version = Version.new(number: 5)
      issue = version.issues.new(name: 'name', description: 'description')
      expect(issue.save).to be_truthy
    end

    it 'is invalid with a description less than 5 characters' do
      version = Version.new(number: 6)
      issue = version.issues.new(name: 'short description', description: '0123')
      expect(issue.save).to be_falsey
    end
  end
end