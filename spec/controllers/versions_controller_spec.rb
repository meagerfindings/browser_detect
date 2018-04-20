# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VersionsController, type: :controller do
  let(:portal) { Portal.last }
  let(:versions) { Portal.last.versions.all }
  let(:version) { Portal.last.versions.last }

  describe 'Get Index' do
    before(:each) do
      temp_portal = Portal.new(name: 'tester', current: rand(2000))
      temp_portal.save
      temp_version = Version.new(portal_id: temp_portal.id)
      temp_version.save
    end

    it 'renders the index template' do
      get :index, params: { portal_id: portal.id }
      expect(response).to render_template('index')
    end

    it 'returns the entire version list' do
      get :index, params: { portal_id: portal.id }
      expect(assigns(:version)).to eq(versions)
    end

    it 'has a 200 status code' do
      get :index, params: { portal_id: portal.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Create Portal' do
    before(:each) do
      temp_portal = Portal.new(name: 'TK421', current: rand(2000))
      temp_portal.save
    end

    it 'redirects to Portal' do
      num = rand(1000)
      post :create, params: { portal_id: portal.id,
                              version: { number: num } }
      expect(response).to redirect_to(portal_path(portal))
    end

    it 'loads New Template when invalid' do
      # Duplicate version numbers cannot exist in the same portal
      post :create, params: { portal_id: portal.id,
                              version: { number: 8 } }
      post :create, params: { portal_id: portal.id,
                              version: { number: 8 } }
      expect(response).to render_template('new')
    end

    it 'sets the version number' do
      post :create, params: { portal_id: portal.id,
                              version: { number: 333 } }
      expect(assigns(:version).number).to eq(333)
    end
  end

  describe 'EDIT' do
    before(:each) do
      temp_portal = Portal.new(name: 'TK421', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand(200..300))
      temp_version.save
    end

    it 'loads version EDIT template' do
      get :edit, params: { version: { number: rand(100) }, id: version.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'UPDATE' do
    before(:each) do
      temp_portal = Portal.new(name: 'TK421', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand(200..300))
      temp_version.save
    end

    it 'updates the Version Number' do
      post :update, params: { id: version.id, version: { number: 343 } }
      expect(assigns(:version).number).to eq(343)
    end

    it 'redirects to version' do
      post :update, params: { id: version.id, version: { number: rand } }
      expect(response).to redirect_to(version_path(version.id))
    end

    it 'renders EDIT on failure' do
      post :update, params: { id: Version.last.id, version: { number: '' } }
      expect(response).to render_template('edit')
    end
  end

  describe 'Get SHOW' do
    before(:each) do
      temp_portal = Portal.new(name: 'TK421', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand(200..300))
      temp_version.save
    end

    it 'gives success status' do
      get :show, params: { id: version.id }
      expect(response).to have_http_status(:ok)
    end

    it 'loads the show template' do
      get :show, params: { id: version.id }
      expect(response).to render_template('show')
    end
  end

  describe 'DESTROY' do
    before(:each) do
      temp_portal = Portal.new(name: 'TK421', current: rand(2000))
      temp_portal.save
      temp_version = temp_portal.versions.new(number: rand(200..300))
      temp_version.save
    end

    it 'destroys the version' do
      start = versions.count
      delete :destroy, params: { id: version.id }
      expect(start).not_to eq(versions.count)
    end

    it 'redirects to Portal' do
      delete :destroy, params: { id: version.id}
      expect(response).to redirect_to(portal_path(portal))
    end
  end
end
