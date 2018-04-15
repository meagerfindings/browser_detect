require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  # TODO: How can I test for self.add_attribute(user_agent) at app/models/visitor.rb:4?

  test 'should only add valid emails' do
    visitor = Visitor.new(email: 'tester@email.com')
    assert_equal visitor.email, 'tester@email.com'

    visitor = Visitor.new(email: 'invalid')
    assert_not_equal visitor.email, 'invalid'

  end
end