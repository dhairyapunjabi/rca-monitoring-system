Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create, :edit, :update, :destroy]
  root 'rcas#index'
end
