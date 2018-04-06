require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # TODO: How can I test for self.add_attribute(user_agent) at app/models/visitor.rb:4?
  test 'should add attributes to self' do
    # post visitors_url, params: { visitor: { email: 'tester@email.com',
    #                                         browser: "Chrome",
    #                                         version: '4',
    #                                         os: 'GameBoy Color',
    #                                         comp_mode: true } }
    # browser = Browser.new(user_agent)
    # assert_equal browser.name, visitor.browser
    # assert_equal browser.full_version, visitor.version
    # assert_equal browser.platform, visitor.os
    # assert_equal browser.compatibility_view?, visitor.comp_mode
    # visitor = Visitor.add_attributes(user_agent)
    # assert_equal 'Chrome', visitor.browser
    # assert_equal '4', visitor.version
    # assert_equal 'GameBoy Color', visitor.os
    # assert_equal true, visitor.comp_mode
  end

end
