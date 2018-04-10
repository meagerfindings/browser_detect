require 'test_helper'

class VisitorsControllerTest < ActionDispatch::IntegrationTest
  test 'should load index page' do
    get '/api/v1/visitors/index'
    assert_response :success
  end

  test 'should render index results' do
    get '/api/v1/visitors/index'
    visitors = JSON.parse(@response.body)

    assert_equal Visitor.count, visitors.count
  end

  test 'should show visitor information' do
    get '/api/v1/visitors/' + Visitor.first.id.to_s
    assert_response :success

    visitor = JSON.parse(@response.body)

    assert_equal Visitor.first.adblock, visitor['adblock']
    assert_equal Visitor.first.browser, visitor['browser']
    assert_equal Visitor.first.comp_mode, visitor['comp_mode']
    assert_equal Visitor.first.css, visitor['css']
    assert_equal Visitor.first.email, visitor['email']
    assert_equal Visitor.first.id, visitor['id']
    assert_equal Visitor.first.os, visitor['os']
    assert_equal Visitor.first.third_cookies, visitor['third_cookies']
    assert_equal Visitor.first.version, visitor['version']
  end

  test 'should create visitor' do
    assert_difference('Visitor.count') do
      post '/api/v1/visitors?visitor[email]=pizzapizzapie'
      assert_response :success
    end
    assert_equal 'pizzapizzapie', Visitor.last.email
  end

  test 'should update visitor' do
    truth = true
    truth = false if Visitor.first.adblock
    id = Visitor.first.id

    put "/api/v1/visitors/#{id}?visitor[adblock]=#{truth}&visitor[email]=1"
    assert_response :success
    assert_equal truth, Visitor.first.adblock
    assert_equal '1', Visitor.first.email
  end

  test 'should delete visitor' do
    start_count = Visitor.count
    delete "/api/v1/visitors/#{Visitor.first.id}"
    assert_response :success
    assert_not_equal start_count, Visitor.count
  end

end