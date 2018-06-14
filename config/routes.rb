Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create, :edit, :update]
  root 'rcas#index'
end
