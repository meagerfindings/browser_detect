Rails.application.routes.draw do
  get 'visitors/index'

  resources :visitors
  root 'visitors#index'

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
