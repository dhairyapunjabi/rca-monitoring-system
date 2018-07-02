Rails.application.routes.draw do
  resources :rcas
  resources :teams, only: [:index, :show]
  resources :tags, only: [:index, :show]
  root 'rcas#index'
end
