Rails.application.routes.draw do
  root "home#index"

  resources :investments
  resources :groups

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'investments-ext', to: 'investments#index_external', as: 'external_investments'
end
