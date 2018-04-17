Rails.application.routes.draw do
  root 'visitors#new'

  resources :visitors
  root 'visitors#index'

  resources :portals do
    resources :versions, shallow: true
  end

  # api
  namespace :api do
    namespace :v1 do
      get 'visitors/index'
      get 'visitors/show'
    end
  end
  namespace :api do
    namespace :v1 do
      resources :visitors, only: %i[index show create update destroy]
    end
  end

end
