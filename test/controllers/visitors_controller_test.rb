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

  test 'should update visitor' do
    vis = Visitor.first

    assert_changes('Visitor.first.email') do
      patch visitor_path(vis), params: { visitor: { email: 'change' } }
    end

    assert_changes('Visitor.first.browser') do
      patch visitor_path(vis), params: { visitor: { browser: 'change' } }
    end

    assert_changes('Visitor.first.version') do
      patch visitor_path(vis), params: { visitor: { version: 'change' } }
    end

    assert_changes('Visitor.first.os') do
      patch visitor_path(vis), params: { visitor: { os: 'change' } }
    end

    assert_changes('Visitor.first.comp_mode') do
      patch visitor_path(vis), params: { visitor: { comp_mode: 'true' } }
    end
  end

  test 'should destroy visitor' do
    assert_changes('Visitor.first.id.to_s') do
      delete visitor_path(Visitor.first)
    end
  end

  # TODO: how do I validate the visitor_params method at app/controllers/visitors_controller.rb:34?
end
