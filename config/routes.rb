Rails.application.routes.draw do
  root 'main#index'

  resources :users, :except => [:destroy]

  devise_for :users
end
