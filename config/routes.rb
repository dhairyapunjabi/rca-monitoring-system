Rails.application.routes.draw do
  get '/ping', to: 'ping#health_check'
  resources :rcas
  resources :teams, only: [:index, :show]
  resources :tags, only: [:index, :show]
  root 'rcas#index'
end
