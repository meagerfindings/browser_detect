require 'rails_helper'

RSpec.describe Portal, type: :model do
  describe 'validations' do
    it 'is valid with a name and current' do
      portal = Portal.new(name: 'test', current: 3)
      expect(portal.save).to be_truthy
    end

    it 'is not valid without a name' do
      portal = Portal.new(current: 3)
      expect(portal.save).to be_falsey
    end

    it 'is not valid without a current version' do
      portal = Portal.new(name: 'math')
      expect(portal.save).to be_falsey
    end

    it 'is not valid with a string for current' do
      portal = Portal.new(name: "ma test", current: "four")
      expect(portal.save).to be_falsey
    end

    it 'is not a duplicate' do
      portal = Portal.new(name: 'Edge', current: 5)
      portal.save

      portal2 = Portal.new(name: 'Edge', current: 5)
      expect(portal2.save).to be_falsey
    end
  end

  describe 'relationships' do
    it 'has many version' do
      portal = Portal.new(name: 'test', current: 3)
      expect(portal).to respond_to(:versions)
    end
  end
end
