require 'test_helper'

class VisitorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get visitors_url
    assert_response :success
  end

  test 'should create visitor and navigate to visitor' do
    assert_difference('Visitor.count') do
      post visitors_url, params: { visitor: { email: 'tester@email.com',
                                              browser: "Mario's Castle",
                                              version: '4',
                                              os: 'Mushroom Kingdom',
                                              comp_mode: true } }
    end
    assert_redirected_to visitor_path(Visitor.last)
  end

  test 'should show visitor' do
    get visitor_path(Visitor.first)
    assert_response :success
  end

  # TODO: how do I validate the visitor_params method at app/controllers/visitors_controller.rb:34?
end
