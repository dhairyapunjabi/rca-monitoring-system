Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :teams, only: [:index, :show]
  root 'rcas#index'
end
