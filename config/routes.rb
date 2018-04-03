Rails.application.routes.draw do
  get 'visitors/index'

  resources :visitors

  root 'visitors#index'
end
