require 'rails_helper'

RSpec.describe Visitor, type: :model do
  describe 'validations' do
    it 'is valid with an email address' do
      visitor = Visitor.new(email: 'test@test.com')
      expect(visitor.save).to be_truthy
    end

    it 'is not valid without an email address' do
      visitor = Visitor.new
      expect(visitor.save).to be_falsey
    end

    it 'is not valid without a valid email address' do
      visitor = Visitor.new(email: 'test')
      expect(visitor.save).to be_falsey

      visitor2 = Visitor.new(email: 'test@.com')
      expect(visitor2.save).to be_falsey

      visitor3 = Visitor.new(email: '@.gmail.com')
      expect(visitor3.save).to be_falsey

      visitor4 = Visitor.new(email: 'j@gmailcom')
      expect(visitor4.save).to be_falsey

      visitor5 = Visitor.new(email: 'j@.gmail.net')
      expect(visitor5.save).to be_falsey
    end
    
    it 'is valid with valid email addresses' do
      visitor1 = Visitor.new(email: 'mat@gmail.net')
      expect(visitor1.save).to be_truthy

      visitor2 = Visitor.new(email: 'mat@gmail.com')
      expect(visitor2.save).to be_truthy

      visitor3 = Visitor.new(email: 'mat.greten@gmail.com')
      expect(visitor3.save).to be_truthy

      visitor4 = Visitor.new(email: 'mat+.greten@gmail.com')
      expect(visitor4.save).to be_truthy
    end

  end
end
