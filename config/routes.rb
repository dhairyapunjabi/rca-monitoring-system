Rails.application.routes.draw do
  resources :rcas
  resources :teams, only: [:index, :show]
  root 'rcas#index'
end
