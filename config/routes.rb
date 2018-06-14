Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create]
  root 'rcas#index'
end
