# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortalsController, type: :controller do
  let(:portals) { Portal.all }
  let(:portal) { Portal.last }

  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'returns the entire portal list' do
      get :index
      expect(assigns(:portals)).to eq(portals)
    end

    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET new' do
    it 'loads new portal page' do
      get :new
      expect(response).to render_template('new')
    end

    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Create New Portal' do
    it 'redirects to new portal after valid creation' do
      post :create, params: { portal: { name: 'name', current: 7, id: 1 } }
      expect(response).to redirect_to(portal_path(portal))
    end

    it 'loads NEW after invalid creation' do
      post :create, params: { portal: { id: 1 } }
      expect(response).to render_template('new')
    end

    it 'sets the portal name' do
      name = 'name test'
      post :create, params: { portal: { id: 1, name: name, current: 7} }
      expect(assigns(:portal).name).to eq(name)
    end
  end

  describe 'Get EDIT' do
    it 'loads portal edit page' do
      post :create, params: { portal: { name: 'name', current: 7, id: 111 } }
      get :edit, params: { id: portal.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'Post EDIT' do
    it 'updates the portal' do
      post :create, params: { portal: { name: 'name', current: 7, id: 333 } }
      name = 'name'
      post :update, params: { portal: { name: name, current: 8 }, id: portal.id }
      expect(assigns(:portal).name).to eq(name)
      expect(assigns(:portal).current).to eq(8)
    end

    it 'redirects to portal successful update' do
      post :create, params: { portal: { name: 'test', current: 7, id: 565 } }
      name = 'name'
      post :update, params: { portal: { name: name, current: 82 }, id: portal.id }
      expect(response).to redirect_to(portal_path(portal))
    end

    it 'renders edit on failed update' do
      post :create, params: { portal: { name: 'name', current: 7, id: 1 } }
      post :update, params: { portal: { name: '', current: 9 }, id: portal.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'get show' do
    it 'loads the portal' do
      post :create, params: { portal: { name: 'name', current: 7, id: 555 } }
      get :show, params: { id: portal.id }
      expect(response).to render_template('show')
    end
  end

  describe 'delete destroy' do
    it 'destroys the portal' do
      post :create, params: { portal: { name: 'name', current: 7, id: 789 } }
      start = portals.count
      delete :destroy, params: { id: portal.id }
      expect(start).not_to eq(portals.count)
    end

    it 'redirects to the index' do
      post :create, params: { portal: { name: 'name', current: 7, id: 909 } }
      delete :destroy, params: { id: portal.id }
      expect(response).to redirect_to(portals_path)
    end
  end
end