gem "minitest"     # ensures you"re using the gem, and not the built-in MT
require "minitest/autorun"

class TestVisitorsController < Minitest::Test
  def setup
    @visitor = Visitor.new
  end


end