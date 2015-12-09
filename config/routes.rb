Rails.application.routes.draw do

  root 'main#index'

  get 'users/students'
  get 'users/tutors'

  devise_for :users

  resources :users, :except => [:destroy]

  resources :courses do
    resources :course_elements
  end
  resources :groups


  get 'about' => 'main#about'
  get 'contact' => 'main#contact'


end
