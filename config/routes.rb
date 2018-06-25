Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :teams, only: [:index]
  root 'rcas#index'
end
