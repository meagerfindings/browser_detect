Rails.application.routes.draw do
  get 'password_resets/new'
  root 'visitors#new'

  resources :visitors

  resources :portals do
    resources :versions, shallow: true
    resources :portal_issues, shallow: true
  end

  # resources :portal_issues

  resources :versions do
    resources :issues, shallow: true
  end

  get 'signup' => 'users#new'
  get 'users' => 'users#index'

  resources :users do
    member do
      get :confirm_email
    end
  end

  resources :password_resets


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
