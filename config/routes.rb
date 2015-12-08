Rails.application.routes.draw do

  root 'main#index'

  get 'users/students'
  get 'users/tutors'

  devise_for :users

  resources :users, :except => [:destroy]
  resources :courses
  resources :groups
  resources :course_elements

  get 'about' => 'main#about'
  get 'contact' => 'main#contact'


end
