# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitorsController, type: :controller do
  include UserAuth

  before(:each) do
    employee_login

    temp_visitor = Visitor.new(email: "test#{rand(200)}@gmail.com")
    temp_visitor.save
  end

  let(:visitors) { Visitor.all }
  let(:visitor) { Visitor.last }

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'returns the entire visitor list' do
      get :index
      expect(assigns(:visitors)).to eq(visitors)
    end

    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    it 'loads new visitor page' do
      get :new
      expect(response).to render_template('new')
    end

    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Create New Visitor' do
    it 'redirects to new visitor after valid creation' do
      post :create, params: { visitor: { email: 'test@test.com' } }
      expect(response).to redirect_to(visitor_path(visitor))
    end

    it 'loads NEW after invalid creation' do
      post :create, params: { visitor: { id: 1 } }
      expect(response).to render_template('new')
    end

    it 'sets the visitor email' do
      test_email = 'darth@plagueis.com'
      post :create, params: { visitor: { id: 1, email: test_email } }
      expect(assigns(:visitor).email).to eq(test_email)
    end
  end

  describe 'Get EDIT' do
    it 'loads visitor edit page' do
      get :edit, params: { id: visitor.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'Post EDIT' do
    it 'updates the visitor' do
      test_email = 'new@email.com'

      post :update, params: { visitor: { email: test_email }, id: visitor.id }
      expect(assigns(:visitor).email).to eq(test_email)
    end

    it 'redirects to visitor successful update' do
      test_email = 'new@email.com'

      post :update, params: { visitor: { email: test_email }, id: visitor.id }
      expect(response).to redirect_to(visitor_path(visitor))
    end

    it 'renders edit on failed update' do
      post :update, params: { visitor: { email: 1 }, id: visitor.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'get show' do
    it 'loads the visitor' do
      get :show, params: { id: visitor.id }
      expect(response).to render_template('show')
    end
  end

  describe 'delete destroy' do
    it 'destroys the visitor' do
      start = visitors.count
      delete :destroy, params: { id: visitor.id }
      expect(start).not_to eq(visitors.count)
    end

    it 'redirects to the index' do
      delete :destroy, params: { id: visitor.id }
      expect(response).to redirect_to(visitors_path)
    end
  end
end
