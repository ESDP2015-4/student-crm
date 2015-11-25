Rails.application.routes.draw do
  root 'main#index'

  devise_for :users

  resources :users, :except => [:destroy]

end
