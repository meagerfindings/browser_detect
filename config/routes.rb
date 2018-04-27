Rails.application.routes.draw do
  root 'visitors#new'

  resources :visitors

  resources :portals do
    resources :versions, shallow: true
  end

  resources :versions do
    resources :issues, shallow: true
  end

  get 'signup' => 'users#new'
  resources :users



  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'
  get "login" => 'sessions#new'
  # Deprecating API
  # namespace :api do
  #   namespace :v1 do
  #     get 'visitors/index'
  #     get 'visitors/show'
  #   end
  # end
  # namespace :api do
  #   namespace :v1 do
  #     resources :visitors, only: %i[index show create update destroy]
  #   end
  # end

end
