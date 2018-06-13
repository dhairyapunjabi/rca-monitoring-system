Rails.application.routes.draw do
  resources :rcas, only: [:index, :new]
end
