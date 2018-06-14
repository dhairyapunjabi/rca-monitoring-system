Rails.application.routes.draw do
  resources :rcas, only: [:index, :new, :create, :edit]
  root 'rcas#index'
end
