# frozen_string_literal: true

gem 'minitest' # ensures you"re using the gem, and not the built-in MT
require 'minitest/autorun'

class TestVisitorsController < Minitest::Test
  def setup
    @visitor = Visitor.new
  end

  def test_that_index_loads
    get visitors_url
    assert_response :success
  end
end
