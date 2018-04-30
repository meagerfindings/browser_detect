# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortalIssuesController, type: :controller do
  let(:portal) { Portal.last }
  let(:portal_issues) { portal.portal_issues.all }
  let(:portal_issue) { portal_issues.last }

  include UserAuth
  before(:each) do
    employee_login

    temp_portal = Portal.new(name: 'tester', current: rand(2000))
    temp_portal.save
    temp_portal_issue = temp_portal.portal_issues.new(name: 'test', description: 'testtesttesttest')
    temp_portal_issue.save
  end

  describe 'Get Index' do
    it 'has a 200 status code' do
      # get :index, params: { portal_id: portal.id }
      get :index, params: { portal_id: portal.id,  }
      expect(response).to have_http_status(200)
    end

    it 'renders index template' do
      get :index, params: { portal_id: portal.id }
      expect(response).to render_template('index')
    end

    it 'returns the entire list' do
      get :index, params: { portal_id: portal.id }
      expect(assigns(:portal_issues)).to eq(portal_issues)
    end
  end

  describe 'New Issue' do
    it 'gives no_content' do
      post :new, params: { portal_id: portal.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Create Issue' do
    it 'gives status code 302' do
      put :create, params: { portal_id: portal.id,
                             portal_issue: {
                               name: 'Harry\s Tears',
                               description: 'What Hermione prevents all the time.'
                             } }
      expect(response).to have_http_status(302)
    end

    it 'renders show on success' do
      put :create, params: { portal_id: portal.id,
                             portal_issue: {
                               name: 'Wizard Chess',
                               description: 'A game that no muggle can win.'
                             } }
      expect(response).to redirect_to(portal_issue_path(portal_issue))
    end

    it 'renders create on failure' do
      put :create, params: { portal_id: portal.id,
                             portal_issue: {
                               name: 'Quiditch',
                               description: '0123'
                             } }
      expect(response).to render_template('new')
    end
  end

  describe 'Get Show' do
    it 'renders show' do
      get :show, params:  { id: portal_issue.id }
      expect(response).to render_template('show')
    end

    it 'gives status code 200' do
      get :show, params: { id: portal_issue.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Get Edit' do
    it 'renders edit' do
      get :edit, params: { id: portal_issue.id }
      expect(response).to render_template('edit')
    end

    it 'gives status code 200' do
      get :edit, params: { id: portal_issue.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Post Update' do
    it 'gives status code 302' do
      post :update, params: { id: portal_issue.id,
                              portal_issue: { name: 'new name',
                                       description: 'new day1' } }
      expect(response).to have_http_status(302)
    end

    it 'redirects to issue if successful' do
      post :update, params: { id: portal_issue.id,
                              portal_issue: { name: 'new name2',
                                       description: 'new day2' } }
      expect(response).to redirect_to(portal_issue_path(portal_issue))
    end

    it 'renders edit if failure' do
      post :update, params: { id: portal_issue.id,
                              portal_issue: { name: 'fail',
                                       description: '0123' } }
      expect(response).to render_template('edit')
    end

    it 'updates name' do
      new_name = 'mewithoutyou'
      post :update, params: { id: portal_issue.id,
                              portal_issue: { name: new_name,
                                       description: 'new day2' } }
      expect(assigns(:portal_issue).name).to eq(new_name)
    end

    it 'updates description' do
      new_description = 'All circles presuppose..'
      post :update, params: { id: portal_issue.id,
                              portal_issue: { name: 'new name4',
                                       description: new_description } }
      expect(assigns(:portal_issue).description).to eq(new_description)
    end

    describe 'Delete' do
      it 'deletes the issue' do
        start = portal_issues.count
        delete :destroy, params: { id: portal_issue.id }
        expect(start).not_to eq(portal_issues.count)
      end

      it 'redirects to the index' do
        delete :destroy, params: { id: portal_issue.id }
        expect(response).to redirect_to(portal_issue_path(portal))
      end
    end
  end
end
