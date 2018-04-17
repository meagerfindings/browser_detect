require 'rails_helper'

RSpec.describe Version, type: :model do
  describe 'validations' do
    it 'is valid with a number' do
      portal = Portal.new(name: 'portal',
                          current: 7)

      version = portal.versions.new(number: 7,
                                    portal_id: 1)
      expect(version.save).to be_truthy
    end

    it 'is invalid without a number' do
      version = Version.new
      expect(version.save).to be_falsey
    end

    it 'is invalid if number is not unique' do
      portal = Portal.new(name: 'portal2',
                          current: 9)

      version = portal.versions.new(number: 55,
                                    portal_id: 35)
      version.save

      version1 = portal.versions.new(number: 55,
                                    portal_id: 35)
      expect(version1.save).to be_falsey
    end
  end

  describe 'relationships' do
    it 'has many issues' do
      version = Version.new(number: 13)
      expect(version).to respond_to(:issues)
    end
  end
end