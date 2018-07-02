Rails.application.routes.draw do
  resources :rcas
  resources :teams, only: [:index, :show]
  resources :tags, only: [:index]
  root 'rcas#index'
end
