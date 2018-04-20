# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssuesController, type: :controller do
  let(:version) { Version.last }
  let(:issues) { version.issues.all }
  let(:issue) { issues.last }

  describe 'Get Index' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
      temp_issue = temp_version.issues.new(name: 'test', description: 'test2')
      temp_issue.save
    end

    it 'has a 200 status code' do
      get :index, params: { version_id: version.id }
      expect(response).to have_http_status(:ok)
    end

    it 'renders index template' do
      get :index, params: { version_id: version.id }
      expect(response).to render_template('index')
    end

    it 'returns the entire list' do
      get :index, params: { version_id: version.id }
      expect(assigns(:issue)).to eq(issues)
    end
  end

  describe 'New Issue' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
    end

    it 'gives no_content' do
      post :new, params: { version_id: version.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Create Issue' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
    end

    it 'gives status code 200' do
      put :create, params: { version_id: version.id,
                             issue: {
                               name: 'Harry\s Tears',
                               description: 'What Hermione prevents all the time.'
                             } }
      expect(response).to have_http_status(:ok)
    end

    it 'renders show on success' do
      put :create, params: { version_id: version.id,
                             issue: {
                               name: 'Wizard Chess',
                               description: 'A game that no muggle can win.'
                             } }
      expect(response).to render_template('show')
    end

    it 'renders create on failure' do
      put :create, params: { version_id: version.id,
                             issue: {
                               name: 'Quiditch',
                               description: '0123'
                             } }
      expect(response).to render_template('new')
    end
  end

  describe 'Get Show' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
      temp_issue = temp_version.issues.new(name: 'test', description: 'test2')
      temp_issue.save
    end

    it 'renders show' do
      get :show, params:  { id: issue.id }
      expect(response).to render_template('show')
    end

    it 'gives status code 200' do
      get :show, params: { id: issue.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Get Edit' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
      temp_issue = temp_version.issues.new(name: 'test', description: 'test2')
      temp_issue.save
    end

    it 'renders edit' do
      get :edit, params: { id: issue.id }
      expect(response).to render_template('edit')
    end

    it 'gives status code 200' do
      get :edit, params: { id: issue.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Post Update' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand)
      temp_version.save
      temp_issue = temp_version.issues.new(name: 'test', description: 'test2')
      temp_issue.save
    end

    it 'gives status code 302' do
      post :update, params: { id: issue.id,
                              issue: { name: 'new name',
                                       description: 'new day1' } }
      expect(response).to have_http_status(302)
    end

    it 'redirects to issue if successful' do
      post :update, params: { id: issue.id,
                              issue: { name: 'new name2',
                                       description: 'new day2' } }
      expect(response).to redirect_to(issue_path(issue))
    end

    it 'renders edit if failure' do
      post :update, params: { id: issue.id,
                              issue: { name: 'fail',
                                       description: '0123' } }
      expect(response).to render_template('edit')
    end

    it 'updates name' do
      new_name = 'mewithoutyou'
      post :update, params: { id: issue.id,
                              issue: { name: new_name,
                                       description: 'new day2' } }
      expect(assigns(:issue).name).to eq(new_name)
    end

    it 'updates description' do
      new_description = 'All circles presuppose..'
      post :update, params: { id: issue.id,
                              issue: { name: 'new name4',
                                       description: new_description } }
      expect(assigns(:issue).description).to eq(new_description)
    end
  end
end
