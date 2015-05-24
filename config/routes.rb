Mapit::Application.routes.draw do
  root to: 'pages#front'

  resources :users, only: [:create]
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'home', to: 'locations#index'

  resources :locations
  resources :sessions, only: [:create, :destroy]
end
